var project = new Project('SpaceShift');
project.addAssets('Assets/**');
project.addLibrary('libnoise');
project.addLibrary('thx.core');
project.addLibrary('thx.unit');
project.addLibrary('edge');
project.addSources('Sources');

return project;
