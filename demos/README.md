# ORRA Demos

This section is meant to house the documentation, configuration, and code needed to demonstrate functional solutions composed of ORRA components.  Some demos will be intended for developers, and some for production environments.  The folder name should indicate which.

## Developers

### SDO-OH-EXF-dev-simple

This demo was created for the THINK 2021 conference and begins with the Open Horizon all-in-one Management Hub and 
Agent installed in a single VM.  It loads the service definition and pattern files for EdgeX Foundry into the 
Management Hub, and then uses a modified SDO script to first-time boot the simulated Agent. The Agent is automatically
configured, and then EdgeX Foundry is automatically deployed by the Agent.  The EdgeX Foundry instance is configured 
with a Random Number Device, so we can demonstrate the platform functioning immediately after installation.

### OH-EXF-Kamakura
EdgeX Foundry Kamakura w/ Onvif Device Service + Edge Video Analytics + Camera Management Example App.

#### Screenshots
<img src="./OH-EXF-Kamakura/docs/images/ptz.png" width="75%">
<br/>
<img src="./OH-EXF-Kamakura/docs/images/ui.png" width="37.5%">
<br/>
<img src="./OH-EXF-Kamakura/docs/images/inference.png" width="75%">
