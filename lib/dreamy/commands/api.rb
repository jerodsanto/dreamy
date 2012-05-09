module Dreamy::Command
  class Api < Base
    def cmds
      cmds = @account.api_cmds
      cmd_table = table do |t|
        t.headings = ['Command']
        cmds.each do |c| 
          t << [c.first]
        end
      end
      display cmd_table
    end

    def cmd_args
      cmds = @account.api_cmds
      cmd_table = table do |t|
        t.headings = 'Command', 'Arguments', 'Results'
        cmds.each do |c| 
          cmd, args, results = *c
          if args.empty? && results.empty?
            t << c
          else
            [args.size, results.size].max.times do
              arg = args.shift
              result = results.shift
              t << [cmd, arg, result]
              cmd = ''
            end
          end
        end
      end
      display cmd_table
    end

  end
end
