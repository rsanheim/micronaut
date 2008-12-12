module Micronaut

  class Runner
        
    def self.installed_at_exit?
      @installed_at_exit ||= false
    end

    def self.autorun
      at_exit { Micronaut::Runner.new.run(ARGV) ? exit(0) : exit(1) } unless installed_at_exit?
      @installed_at_exit = true
    end
    
    def options
      Micronaut.configuration.options
    end

    def run(args = [])
      @verbose = args.delete('-v')
       behaviours_to_run = Micronaut::World.behaviours_to_run
       total_examples = behaviours_to_run.inject(0) { |sum, eg| sum + eg.examples_to_run.size }
       
       old_sync, options.formatter.output.sync = options.formatter.output.sync, true if options.formatter.output.respond_to?(:sync=)
              
       options.formatter.start(total_examples)

       suite_success = true
      
       starts_at = Time.now
       behaviours_to_run.each do |example_group|
         suite_success &= example_group.run(options.formatter)
       end
       duration = Time.now - starts_at
       
       options.formatter.start_dump
       options.formatter.dump_pending
       options.formatter.dump_failures
       options.formatter.dump_summary(duration, total_examples, options.formatter.failed_examples.size, options.formatter.pending_examples.size)
      
       options.formatter.output.sync = old_sync if options.formatter.output.respond_to? :sync=
       
       suite_success
    end
    
  end
  
end