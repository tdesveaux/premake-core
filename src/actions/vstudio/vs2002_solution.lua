--
-- vs2002_solution.lua
-- Generate a Visual Studio 2002 solution.
-- Copyright (c) 2009 Jason Perkins and the Premake project
--

	function premake.vs2002_solution(sln)
		io.eol = '\r\n'

		io.printf('Microsoft Visual Studio Solution File, Format Version 7.00')
		
		-- Write out the list of project entries
		for prj in premake.eachproject(sln) do
			local projpath = path.translate(path.getrelative(sln.location, _VS.projectfile(prj)))
			io.printf('Project("{%s}") = "%s", "%s", "{%s}"', _VS.tool(prj), prj.name, projpath, prj.uuid)
			io.printf('EndProject')
		end

		io.printf('Global')
		io.printf('\tGlobalSection(SolutionConfiguration) = preSolution')
		for i, cfgname in ipairs(sln.configurations) do
			io.printf('\t\tConfigName.%d = %s', i - 1, cfgname)
		end
		io.printf('\tEndGlobalSection')

		io.printf('\tGlobalSection(ProjectDependencies) = postSolution')
		io.printf('\tEndGlobalSection')
		
		io.printf('\tGlobalSection(ProjectConfiguration) = postSolution')
		for prj in premake.eachproject(sln) do
			for _, cfgname in ipairs(sln.configurations) do
				io.printf('\t\t{%s}.%s.ActiveCfg = %s|%s', prj.uuid, cfgname, cfgname, _VS.arch(prj))
				io.printf('\t\t{%s}.%s.Build.0 = %s|%s', prj.uuid, cfgname, cfgname, _VS.arch(prj))
			end
		end
		io.printf('\tEndGlobalSection')
		io.printf('\tGlobalSection(ExtensibilityGlobals) = postSolution')
		io.printf('\tEndGlobalSection')
		io.printf('\tGlobalSection(ExtensibilityAddIns) = postSolution')
		io.printf('\tEndGlobalSection')
		
		io.printf('EndGlobal')
	end
	