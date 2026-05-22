class DebtSimplifier
  def self.call(balances)
    creditors = []
    debtors = []

    balances.each do |user_id, amount|
      if amount > 0
        creditors << { user_id: user_id, amount: amount }
      elsif amount < 0
        debtors << { user_id: user_id, amount: -amount }
      end
    end

    settlements = []

    i = 0
    j = 0

    while i < debtors.length && j < creditors.length
      debtor = debtors[i]
      creditor = creditors[j]

      amount = [ debtor[:amount], creditor[:amount] ].min

      settlements << {
        from: debtor[:user_id],
        to: creditor[:user_id],
        amount: amount
      }

      debtor[:amount] -= amount
      creditor[:amount] -= amount

      i += 1 if debtor[:amount] <= 0
      j += 1 if creditor[:amount] <= 0
    end

    settlements
  end
end
