# -*- coding: utf-8 -*-

require 'helper'

class TestRegressionChartPoints06 < Minitest::Test
  def setup
    setup_dir_var
  end

  def teardown
    @tempfile.close(true)
  end

  def test_chart_points06
    @xlsx = 'chart_points06.xlsx'
    workbook  = WriteXLSX.new(@io)
    worksheet = workbook.add_worksheet
    chart     = workbook.add_chart(type: 'column', embedded: 1)

    # For testing, copy the randomly generated axis ids in the target xlsx file.
    chart.instance_variable_set("@axis_ids", [71050368, 71051904])

    data = [
      [1, 2, 3,  4,  5],
      [2, 4, 6,  8, 10],
      [3, 6, 9, 12, 15]
    ]

    worksheet.write('A1', data)

    chart.add_series(
      categories: '=Sheet1!$A$1:$A$5',
      values:     '=Sheet1!$B$1:$B$5',
      marker:     { type: 'automatic' },
      points:     [
        { fill: { color: 'red' } }
      ]
    )
    chart.add_series(
      categories: '=Sheet1!$A$1:$A$5',
      values:     '=Sheet1!$C$1:$C$5',
      marker:     { type: 'automatic' }
    )

    worksheet.insert_chart('E9', chart)

    workbook.close
    compare_for_regression
  end
end
