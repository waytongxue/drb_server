require 'drb'
require 'timeout'

def wait_drb_server_up(drbobj,time=120)
  begin
    Timeout.timeout(time) do
      begin
        drbobj.ping 
      rescue DRb::DRbConnError
        sleep 1
        retry
      end
    end
  rescue Timeout::Error
    return false
  end
end


SIP = '127.0.0.1'
SPORT = 19527
URI = "druby://#{SIP}:#{SPORT}"

DRb.start_service
sobj = DRbObject.new(nil,URI)

# wait_drb_server_up(sobj)    #=> wait for server up, defalut timeout=120s
# sobj.change_password(username,passwd)   #=>  true or false
# text = sobj.cmd('ipconfig')             #=>  cmd result