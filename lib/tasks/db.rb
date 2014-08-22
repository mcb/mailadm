Sequel.extension :migration

def migrations_dir
  Mailadm::Util::PathHelper.absolute_path("db/migrations")
end

namespace :db do
  desc "Prints current schema version"
  task :version do
    version = if Sequel::Model.db.tables.include?(:schema_info)
      Sequel::Model.db[:schema_info].first[:version]
    end || 0

    puts "Schema Version: #{version}"
  end

  desc "Perform migration up to latest migration available"
  task :migrate, [:target] do |t, args|
    if args[:target]
      puts "Migrating to version #{args[:target]}"
      Sequel::Migrator.run(Sequel::Model.db, migrations_dir, target: args[:target].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(Sequel::Model.db, migrations_dir)
    end

    Rake::Task['db:version'].execute
  end

  desc "Perform rollback to specified target or full rollback as default"
  task :rollback, [:target] do |t, args|
    args.with_defaults(:target => 0)

    Sequel::Migrator.run(Sequel::Model.db, migrations_dir, :target => args[:target].to_i)
    Rake::Task['db:version'].execute
  end
end
