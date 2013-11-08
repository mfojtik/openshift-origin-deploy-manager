module DeploymentsHelper

  require 'digest/md5'

  def commit(commit_id)
    Dir.chdir(File.join(ENV['OPENSHIFT_HOMEDIR'], 'git', "#{ENV['OPENSHIFT_APP_NAME']}.git")) do
      parse_git_commit %x[git show -s --pretty=full #{commit_id}]
    end
  end

  def h(text)
    Rack::Utils.escape_html(text)
  end

  private

  def parse_git_commit(commit)
    data = commit.split("\n")
    result = {
      'author' => data[1].split(" ", 2)[1],
      'message' => data[3..-1].map { |m| m.strip }.join("\n")
    }
    result['author_digest'] = Digest::MD5::hexdigest(parse_email_from(result['author']))
    result
  end

  def parse_email_from(author)
    author.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i).first
  end

end
