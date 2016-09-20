class Admin::PdfEmailAlertsController < AdminController
  include Admin::ApplicationHelper

  def index
    @email_alerts = PdfEmailAlert.latest.paginate(paginate_params)
  end

  def new
    @pdf_email_alert = PdfEmailAlert.new(status: :initial)
  end

  def create
    @pdf_email_alert = PdfEmailAlert.new(pdf_email_alert_params.merge(status: 'initial'))
    if @pdf_email_alert.save
      @pdf_email_alert.file = PdfFileCreator.create(@pdf_email_alert.posts)
      @pdf_email_alert.status = 'ready'
      @pdf_email_alert.save

      flash[:success] = 'Pdf Email Alert successfully created'
      redirect_to preview_admin_pdf_email_alert_path(@pdf_email_alert)
    else
      flash[:error] = 'Unable to create Pdf Email Alert.'
      render 'new'
    end
  end

  def preview
    @pdf_email_alert = PdfEmailAlert.find(params[:id])
  end

  def send_pdf
    @pdf_email_alert = PdfEmailAlert.find(params[:id])
    @pdf_email_alert.greeting_message = prepare_for_html(@pdf_email_alert.greeting_message || '')
    MailgunService.new.send_pdf(@pdf_email_alert)
    @pdf_email_alert.sent!

    redirect_to admin_pdf_email_alerts_path
  end

  protected
  def pdf_email_alert_params
    params.require(:pdf_email_alert).permit(:greeting_message, user_groups: [])
  end
end