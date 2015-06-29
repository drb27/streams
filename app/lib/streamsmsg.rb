class StreamsMsg
  SUCCESS=0
  WARNING=1
  ERROR=2

  @@tags = {
    0 => 'msgsuccess',
    1 => 'msgwarning',
    2 => 'msgerror'
  }

  attr_reader :severity

  def initialize msg=[],sev=0
    @messages=msg.clone
    @severity=sev
  end

  def messages
    @messages.clone
  end

  def add_msg msg,sev=StreamsMsg::SUCCESS
    @messages << msg
    @severity = StreamsMsg::max [@severity,sev]
  end

  def <<(d)
    self.add_msg d[:message], d[:severity]
  end

  def tag
    @@tags[@severity]
  end

  def each
    @messages.each { |m| yield m }
  end

  def count
    @messages.count
  end

  def messages?
    @messages.count>0
  end

  def self.max a
    result = StreamsMsg::SUCCESS
    a.each do |i|
      if i>result 
        result=i
      end
    end
    return result
  end
  
end
