class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all

    render json: @contacts
  end

  # GET /contacts/1
  def show
    #render json: @contact
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        y_position = pdf.cursor
        pdf.text 'Hello World!'
        # pdf = PDFS::PdfTests.new
        # pdf.table([["foo", "bar", "baz"], [{content: "foo",colspan: 2}]]) do |t|
        #   t.cells.border_width = 1
        #   t.before_rendering_page do |page|
        #     page.row(0).border_top_width = 3
        #     page.row(-1).border_bottom_width = 3
        #     # page.column(0).border_left_width
        #     # page.column(-1).border_right_width
        #   end
        # end
        pdf.bounding_box([300, y_position], width: 200) do
          pdf.text 'This bounding box has variable height. No matter how much text is ' \
          'written here, the height will expand to fit.'
          pdf.text ' _' * 1000
          pdf.text ' *' * 1000
          pdf.transparent(0.5) { pdf.stroke_bounds }
        end
        send_data pdf.render, filename: 'pdf-test.pdf', type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:name, :relationship)
    end
end
