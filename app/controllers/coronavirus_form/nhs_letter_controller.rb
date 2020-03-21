# frozen_string_literal: true

class CoronavirusForm::NhsLetterController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  include FieldValidationHelper

  def show
    render "coronavirus_form/#{PAGE}"
  end

  def submit
    nhs_letter = sanitize(params[:nhs_letter]).presence
    session[:nhs_letter] = nhs_letter

    invalid_fields = validate_radio_field(
      PAGE,
      radio: nhs_letter,
    )

    if invalid_fields.any?
      flash.now[:validation] = invalid_fields
      render "coronavirus_form/#{PAGE}"
    else
      redirect_to controller: "coronavirus_form/#{NEXT_PAGE}", action: "show"
    end
  end

private

  PAGE = "nhs_letter"
  NEXT_PAGE = "check_answers"

  def previous_path
    "/"
  end
end