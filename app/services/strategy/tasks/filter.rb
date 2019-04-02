class Strategy::Tasks::Filter < AStrategy

  def process

    accountant = driver
    bucket[:tasks] = Task.where(accountant_id: accountant.id)
    true

  end

end