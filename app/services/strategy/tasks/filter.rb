class Strategy::Tasks::Filter < AStrategy

  def process

    accountant = driver
    type = bucket[:task_type]
    bucket[:tasks] = Task.where(accountant_id: accountant.id, task_type: type)
    true

  end

end