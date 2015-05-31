class UploadStrongliftsBackupJob < ActiveJob::Base
  queue_as :default

  def perform(user, backup_file, program)
    tmp_dir do |dir|
      `unzip #{backup_file} -d #{dir}`
      importer_for(dir, user, program).import_from(dir)
    end
  end

  private

  def tmp_dir
    Dir.mktmpdir do |dir|
      yield dir
    end
  end

  def importer_for(directory, user, program)
    AndroidImport.new(user, program)
  end
end
