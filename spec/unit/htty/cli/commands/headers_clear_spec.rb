require 'htty/cli/commands/headers_clear'
require 'htty/cli/commands/headers_unset_all'

RSpec.describe HTTY::CLI::Commands::HeadersClear do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      expect(klass.alias_for).to eq(HTTY::CLI::Commands::HeadersUnsetAll)
    end

    it 'should have the expected aliases' do
      expect(klass.aliases).to eq([])
    end

    it 'should belong to the expected category' do
      expect(klass.category).to eq('Building Requests')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('headers-c[lear]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq(nil)
    end

    it 'should have the expected help' do
      expect(klass.help).to eq("Alias for \e[1mheaders-unset-[all]\e[0m")
    end

    it 'should have the expected help_extended' do
      expect(klass.help_extended).to eq("Alias for \e[1mheaders-unset-[all]\e[0m.")
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::HeadersUnsetAll])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('headers-clear', session: :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('headers-c', session: :a_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:a_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', session: :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
