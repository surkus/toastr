require 'test_helper'

class OatTest < ActiveSupport::TestCase
  def setup
    @oat = Oat.create
    @wait_message = { :error => 'Data not yet available' }
  end

  # default expiration

  test 'default toast responds with waiting message on first run' do
    Rails.application.config.active_job.queue_adapter = :non_inline_queue_adapter
    assert_equal @wait_message, @oat.breakfast
  end

  test 'default toast responds with cache on first run if inline adapter' do
    Rails.application.config.active_job.queue_adapter = :inline
    assert_equal 'meal', @oat.breakfast['oat']
  end

  test 'default toast doesnt update toast if not stale' do
    @oat.breakfast
    updated_at = @oat.toasts.last.reload.updated_at
    @oat.breakfast
    assert_equal updated_at, @oat.toasts.last.reload.updated_at
  end

  test 'default toast updates if stale' do
    @oat.breakfast
    updated_at = @oat.toasts.last.reload.updated_at
    @oat.breakfast
    @oat.touch
    @oat.breakfast
    assert_not_equal updated_at, @oat.toasts.last.reload.updated_at
  end

  # expires_in toast

  test 'expires_in toast responds with waiting message on first run' do
    Rails.application.config.active_job.queue_adapter = :non_inline_queue_adapter
    assert_equal @wait_message, @oat.daily_report
  end

  test 'expires_in toast responds with cache on first run if inline adapter' do
    Rails.application.config.active_job.queue_adapter = :inline
    assert_equal 'result', @oat.daily_report['different']
  end

  test 'expires_in toast doesnt update toast if not stale' do
    @oat.daily_report
    updated_at = @oat.toasts.last.reload.updated_at
    assert_equal 'result', @oat.daily_report['different']
    assert_equal updated_at, @oat.toasts.last.reload.updated_at
  end

  test 'expires_in toast updates if stale' do
    @oat.daily_report
    updated_at = @oat.toasts.last.reload.updated_at
    @oat.toasts.last.update_column :updated_at, 2.days.ago # 1.day.ago is the expiration
    assert_equal 'result', @oat.reload.daily_report['different']
    assert_not_equal updated_at, @oat.toasts.last.reload.updated_at
  end

  # arbitrary block toast

  test 'arbitrary block toast responds with waiting message on first run' do
    Rails.application.config.active_job.queue_adapter = :non_inline_queue_adapter
    assert_equal @wait_message, @oat.special
  end

  test 'arbitrary block toast responds with cache on first run if inline adapter' do
    Rails.application.config.active_job.queue_adapter = :inline
    assert_equal 'special', @oat.special['very']
  end

  test 'arbitrary block toast doesnt update toast if not stale' do
    @oat.special
    @oat.update! created_at: '2015-01-01'
    updated_at = @oat.toasts.last.reload.updated_at
    assert_equal 'special', @oat.special['very']
    assert_equal updated_at, @oat.toasts.last.reload.updated_at
  end

  test 'arbitrary block toast updates if stale' do
    @oat.special
    @oat.update! created_at: '2015-01-08'
    updated_at = @oat.toasts.last.reload.updated_at
    assert_equal 'special', @oat.reload.special['very']
    assert_not_equal updated_at, @oat.toasts.last.reload.updated_at
  end

  # other tests

  test 'avoids n+1 by allowing MyActiveRecord.includes(:toasts)...' do
    4.times do
      Oat.create!
    end
    assert_equal 5, Oat.count # plus one fixture

    # build toasts
    Oat.all.each(&:daily_report)

    count = count_queries do
      Oat.all.includes(:toasts).each(&:daily_report)
    end
    assert_equal 2, count
  end

end
