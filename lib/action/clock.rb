class Clock
  def start
    reset # clears @in and @out
    @in = Process.clock_gettime(Process::CLOCK_MONOTONIC) # starts clock by storing starting time in @in
  end

  def stop # stops clock and returns timelapse in ms
    @out = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    (@out - @in) * 1000
  end

  private

  def reset
    @in = nil
    @out = nil
  end
end
