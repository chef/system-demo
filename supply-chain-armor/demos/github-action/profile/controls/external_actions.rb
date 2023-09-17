github_action_file = input('file', value: 'actions/example.yml', description: 'the github action file to test') 

control 'limit_external_actions' do
    title 'Github External Actions must be in the allowed list'
    impact 1.0
    tag 'permission'

    ghAction = yaml(github_action_file)

    ghAction['jobs'].each do |name, job|
        ghAction['jobs', name, 'steps'].each_with_index do |step, index|                    
            if step["uses"] != nil

                describe.one do

                    describe yaml(content: ghAction.raw_content()) do
                        its(['jobs', name, 'steps', index, 'uses']) { should start_with "actions/" }
                    end                

                    describe yaml(content: ghAction.raw_content()) do
                        its(['jobs', name, 'steps', index, 'uses']) { should start_with "atlassian/" }
                    end                

                    describe yaml(content: ghAction.raw_content()) do
                        its(['jobs', name, 'steps', index, 'uses']) { should start_with "chef/" }
                    end                

                    describe yaml(content: ghAction.raw_content()) do
                        its(['jobs', name, 'steps', index, 'uses']) { should start_with "hashicorp/" }
                    end                

                end
            end
        end
    end
end