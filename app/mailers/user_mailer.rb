class UserMailer < ApplicationMailer
  default from: 'notifications@affirm.org'
  
  def government_notification
    #TODO: Add logic here to find all Government email recipients
    @member = 'robert.palmer@hq.dhs.gov'
    @url  = 'http://www.affirm.org'
    mail(to: @member, subject: 'Government contact needs to be contacted?')
  end

  def industry_notification
    #TODO: Add logic here to find all Industry email recipients
    @member = "angela.norris@oracle.com"
    @url  = 'http://www.affirm.org'
    mail(to: @member, subject: 'Industry contact needs to be contacted?')
  end

  def education_notification
    #TODO: Add logic here to find all Education email recipients
    @member = "education_example@example.com"
    @url  = 'http://www.affirm.org'
    mail(to: @member, subject: 'Education contact needs to be contacted?')
  end

  def golf_notification
    #TODO: Add logic here to find all golf (Tom Ragland) email recipients
    @member = "tragland@affirm.org"
    @url  = 'http://www.affirm.org'
    mail(to: @member, subject: 'Golf contact needs to be contacted?')
  end
  
end