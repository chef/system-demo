github_action_file = input('file', value: 'actions/example.yml', description: 'the github action file to test') 

control 'concurrency.cancel-in-progress' do
    title 'Github Action cancel-in-progress should be true'
    impact 0.1
    desc 'If using concurrency in an action cancel-in-progress should be true'
    tag 'best-practice'

    ghAction = yaml(github_action_file)

    only_if('action is not using concurrency') do
        ghAction['concurrency'] != nil
    end

    describe yaml(content: ghAction.raw_content()) do
        its(['concurrency','cancel-in-progress']) { should be true }
    end

end