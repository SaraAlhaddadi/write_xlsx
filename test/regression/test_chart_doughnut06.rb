# -*- coding: utf-8 -*-

require 'helper'

class TestRegressionChartDoughnut06 < Minitest::Test
  def setup
    setup_dir_var
  end

  def teardown
    @tempfile.close(true)
  end

  def test_chart_doughnut06
    @xlsx = 'chart_doughnut06.xlsx'
    workbook  = WriteXLSX.new(@io)
    worksheet = workbook.add_worksheet
    chart     = workbook.add_chart(type: 'doughnut', embedded: 1)

    data = [
      [2,  4,  6],
      [60, 30, 10]
    ]

    worksheet.write('A1', data)

    chart.add_series(values: 'Sheet1!$A$1:$A$3')
    chart.add_series(values: 'Sheet1!$B$1:$B$3')

    worksheet.insert_chart('E9', chart)

    workbook.close
    compare_for_regression
  end
end
