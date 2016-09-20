class CreateDefaultMenuSections < ActiveRecord::Migration
  def up
    PostSection.reset_column_information
    section_names = {
      'Economy' => ['Macro Watch', 'Euro poll', 'Analysis', 'People & Institutions'],
      'ECB' => ['Monetary policy', 'Supervision', 'People'],
      'Policy' => ['Fiscal', 'International', 'Regulation', 'Governance'],
      'Markets' => ['Sovereign bonds', 'Forex', 'Credit & others'],
      'Reform' => ['News', 'Structural survey', 'Periphery']
    }

    section_names.each do |root_section_name, subsection_names|
      parent = PostSection.create(name: root_section_name, in_top_menu: true)
      subsection_names.each do |subsection_name|
        parent.subsections.create(name: subsection_name, in_top_menu: true)
      end
    end
  end
end
