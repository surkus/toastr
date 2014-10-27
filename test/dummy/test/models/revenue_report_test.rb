require 'test_helper'

class RevenueReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'report singletons based on options' do
    r1 = RevenueReport.fetch()
    r2 = RevenueReport.fetch()
    r3 = RevenueReport.fetch({period: :all})
    
    assert r1.id == r2.id
    assert r1.id != r3.id
    assert RevenueReport.count == 2

  end

  test 'new reports return error hash' do
    report = RevenueReport.fetch({ random: rand() })
    data = report.as_json
    assert data.present? && data[:error].present? 
  end

  test 'new reports run' do
    opts = {subtype: :test}
    report = RevenueReport.fetch(opts)
    data = report.as_json
    assert data.present? && data[:error].present? 

    Delayed::Job.last.invoke_job

    report = RevenueReport.fetch(opts)
    data = report.as_json
    assert data.present? && !data[:error].present? 
  end
end
