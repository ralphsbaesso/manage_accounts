
namespace :util do
  desc 'Backup Database'
  task backup: :environment do

    date = DateTime.now.strftime('%Y%m%d%H%M%S')
    puts date

    puts `export PGPASSWORD='root'; pg_dump -h localhost -U postgres manage_accounts> ~/backup/#{date}.txt`
  end

end
