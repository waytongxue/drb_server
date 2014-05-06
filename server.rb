require 'drb'

LOG_FILE = 'c:\rtp_drb_server.log'
URI = 'druby://:19527'

#class of windows 
class WinTool
  # include DRb::DRbUndumped
  def ping
    return true
  end

  def exec_cmd(cmd)
    `#{cmd}`
  end

  def change_password(username,newpasswd)
    ret = system("net user #{username} #{newpasswd}")
    if ret
      File.open(LOG_FILE , 'a') { |f| f.puts("#{Time.now} :" + "success change user=#{username} password=#{newpasswd}") }
    end
    return ret
  end

end

#drb server start
DRb.start_service(URI,WinTool.new)
DRb.thread.join