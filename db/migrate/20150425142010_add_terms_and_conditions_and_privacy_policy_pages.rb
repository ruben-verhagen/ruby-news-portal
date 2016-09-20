class AddTermsAndConditionsAndPrivacyPolicyPages < ActiveRecord::Migration
  def up
    Page.create(title: 'Terms and Conditions', code: 'terms')
    Page.create(title: 'Private Policy', code: 'policy')
  end

  def down
    page = Page.find_by(code: 'terms')
    if page.present?
      page.destroy
    end
    page = Page.find_by(code: 'policy')
    if page.present?
      page.destroy
    end
  end
end
