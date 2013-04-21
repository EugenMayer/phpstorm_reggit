#!/usr/bin/env ruby
require "find"
require "fileutils"
require "pathname"
require "rexml/document"
include REXML

@searchpath = ARGV[0]

#fallback to use the current folder as the working dir, if no other path given as an argument
@searchpath = Dir.pwd unless @searchpath

@searchpath = Pathname.new(@searchpath).realpath.to_s
# we expect this root folder to be a valid PHPstorm project, therefor the configuration folder must exist
vcsconfig= @searchpath + "/.idea/vcs.xml"
(puts "Cant find the .idea/vcs.xml file (#{vcsconfig}) in your current directory (#{@searchpath}). Did you initialize the PHPstorm project already?"; exit) unless File.exist?(vcsconfig)

Git_roots = []
Find.find(@searchpath) do |path|
  if FileTest.directory?(path)
    folder = File.basename(path)
    if folder == ".git"
      git_root = String.new(path).split("/.git")
      git_root = git_root[0]
      Git_roots.push(git_root)
    end
  end
end

xmlfile = File.new(vcsconfig, "r")
xmldoc = Document.new(xmlfile)
xmlfile.close

#thats were all the git-folder mappings are stored in the XML
xml_git_root = xmldoc.elements["/project/component"]

# TODO: Maybe rather compare with the current Git_roots list and exclude existent, rather then delting all existent
# TODO: otherwise, maybe rather delete the component node and recreate it
xml_git_root.elements.each("mapping") {
  # delete any existing vcs mapping entry, as we recreate them all
  |e| xml_git_root.elements.delete(e)
}

# create a entry in the component node for each git folder we found
Git_roots.each do |git_root|
  el = Element.new "mapping"
  el.attributes["vcs"] = "Git"
  el.attributes["directory"] = git_root
  xml_git_root.elements.add(el)
end

# Finally, save it
xmlfile = File.new(vcsconfig, "w")
xmldoc.write(xmlfile,2)
xmlfile.close
