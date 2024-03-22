# require_relative 'lib/services/sheet_syncronizer'

# SheetSyncronizer.new(
#   filename: 'arquivo_path',
#   step: Integration::Syncronizers::Enrollment.new
# ).call

require 'roo'

# essa classe é uma fachada, receberá o caminho do arquivo e a etapa que deverá ser importada
class SheetSyncronizer
  # @kwargs [String] filename
  # @kwargs [a instance of Integration::Syncronizers::Base.new] step

  def initialize(filename:, step:)
    # validar se o arquivo filename existe
    # validar se step existe

    @sheets = Roo::Spreadsheet.open(filename)
    @step = step # Integration::Syncronizers::Enrollment.new
  end

  def call
    @step.call(sheets: @sheets)
  end
end