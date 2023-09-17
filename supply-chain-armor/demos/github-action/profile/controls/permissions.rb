github_action_file = input('file', value: 'actions/example.yml', description: 'the github action file to test') 

control 'permission_actions.contents' do
    title 'Github Action permissions.contents must not be write'
    impact 1.0
    desc 'contents:write allows the action to create a release. '
    desc 'rationale', 'This ensures that there are no unexpected settings' # Requires Chef InSpec >=2.3.4
    tag 'permission'

    ghAction = yaml(github_action_file)

    only_if('action is not targeting main') do
        ghAction[true,'push','branches'] != nil
    end

    only_if('action is not targeting main') do
        ghAction[true,'push','branches'].any? { |branch| branch == 'main'}
    end

    only_if('action does not declare permissions.content') do
        ghAction['permissions','contents'] != nil
    end

    describe yaml(content: ghAction.raw_content()) do
        its(['permissions','contents']) { should be_in ["read","none"] }
    end

end
    
control 'permission_actions.pull-requests' do
    title 'Github Action permissions.pull-requests must not be write'
    impact 1.0
    tag 'permission'

    ghAction = yaml(github_action_file)

    only_if('action is not targeting main') do
        ghAction[true,'push','branches'] != nil
    end

    only_if('action is not targeting main') do
        ghAction[true,'push','branches'].any? { |branch| branch == 'main'}
    end

    only_if('action does not declare permissions.pull-requests') do
        ghAction['permissions','pull-requests'] != nil
    end

    describe yaml(content: ghAction.raw_content()) do
        its(['permissions','pull-requests']) { should be_in ["read","none"] }
    end

end

control 'permission_actions.issues' do
    title 'Github Action permissions.issues must not be write'
    impact 1.0
    tag 'permission'

    ghAction = yaml(github_action_file)

    only_if('action is not targeting main') do
        ghAction[true,'push','branches'] != nil
    end

    only_if('action is not targeting main') do
        ghAction[true,'push','branches'].any? { |branch| branch == 'main'}
    end

    only_if('action does not declare permissions.issues') do
        ghAction['permissions','issues'] != nil
    end

    describe yaml(content: ghAction.raw_content()) do
        its(['permissions','issues']) { should be_in ["read","none"] }
    end

end
    
    
    
    #Scope	Allows an action using GITHUB_TOKEN to
    #actions	Work with GitHub Actions. For example, actions: write permits an action to cancel a workflow run. For more information, see "Permissions required for GitHub Apps."
    #checks	Work with check runs and check suites. For example, checks: write permits an action to create a check run. For more information, see "Permissions required for GitHub Apps."
    #contents	Work with the contents of the repository. For example, contents: read permits an action to list the commits, and contents:write allows the action to create a release. For more information, see "Permissions required for GitHub Apps."
    #deployments	Work with deployments. For example, deployments: write permits an action to create a new deployment. For more information, see "Permissions required for GitHub Apps."
    #discussions	Work with GitHub Discussions. For example, discussions: write permits an action to close or delete a discussion. For more information, see "Using the GraphQL API for Discussions."
    #id-token	Fetch an OpenID Connect (OIDC) token. This requires id-token: write. For more information, see "About security hardening with OpenID Connect"
    #issues	Work with issues. For example, issues: write permits an action to add a comment to an issue. For more information, see "Permissions required for GitHub Apps."
    #packages	Work with GitHub Packages. For example, packages: write permits an action to upload and publish packages on GitHub Packages. For more information, see "About permissions for GitHub Packages."
    #pages	Work with GitHub Pages. For example, pages: write permits an action to request a GitHub Pages build. For more information, see "Permissions required for GitHub Apps."
    #pull-requests	Work with pull requests. For example, pull-requests: write permits an action to add a label to a pull request. For more information, see "Permissions required for GitHub Apps."
    #repository-projects	Work with GitHub projects (classic). For example, repository-projects: write permits an action to add a column to a project (classic). For more information, see "Permissions required for GitHub Apps."
    #security-events	Work with GitHub code scanning and Dependabot alerts. For example, security-events: read permits an action to list the Dependabot alerts for the repository, and security-events: write allows an action to update the status of a code scanning alert. For more information, see "Repository permissions for 'Code scanning alerts'" and "Repository permissions for 'Dependabot alerts'" in "Permissions required for GitHub Apps."
    #statuses	Work with commit statuses. For example, statuses:read permits an action to list the commit statuses for a given reference. For more information, see "Permissions required for GitHub Apps."

