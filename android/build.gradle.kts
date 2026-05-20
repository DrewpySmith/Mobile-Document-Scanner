allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    val configureNamespace = { proj: Project ->
        if (proj.plugins.hasPlugin("com.android.application") || proj.plugins.hasPlugin("com.android.library")) {
            val android = proj.extensions.findByName("android") as? com.android.build.gradle.BaseExtension
            android?.apply {
                if (namespace == null || namespace!!.isEmpty()) {
                    namespace = "com.example.${proj.name.replace("-", ".")}"
                }
            }

            // Task to remove package attribute from manifests to comply with AGP 8.0+
            proj.tasks.register("removePackageAttributeFromManifest") {
                doLast {
                    val manifests = proj.fileTree(proj.projectDir)
                    manifests.include("**/AndroidManifest.xml")
                    manifests.forEach { manifestFile ->
                        var content = manifestFile.readText(java.nio.charset.StandardCharsets.UTF_8)
                        if (content.contains("package=")) {
                            println("Removing package attribute from " + manifestFile.absolutePath)
                            content = content.replace(kotlin.text.Regex("""\s+package="[^"]*""""), "")
                            manifestFile.writeText(content, java.nio.charset.StandardCharsets.UTF_8)
                        }
                    }
                }
            }

            // Configure all manifest-processing tasks to depend on our cleaning task
            proj.tasks.matching { it.name.startsWith("process") && it.name.endsWith("Manifest") }.configureEach {
                dependsOn("removePackageAttributeFromManifest")
            }
        }
    }

    if (project.state.executed) {
        configureNamespace(project)
    } else {
        project.afterEvaluate {
            configureNamespace(this)
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
