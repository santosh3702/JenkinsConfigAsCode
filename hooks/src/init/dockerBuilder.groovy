import java.lang.System
import java.io.File
import hudson.model.*
import jenkins.model.*
import org.jenkinsci.plugins.dockerbuildstep.*
import net.sf.json.JSONObject
import org.kohsuke.stapler.StaplerRequest

def instance = Jenkins.getInstance()
  
def docker = instance.getDescriptor(DockerBuilder.class)

JSONObject dockerProp = new JSONObject()

dockerProp.put("dockerUrl", "unix:///var/run/docker.sock")
dockerProp.put("dockerVersion", "")
dockerProp.put("dockerCertPath", "")

docker.configure(null,dockerProp)

instance.save()
