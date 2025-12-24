from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMakeDeps

required_conan_version = ">=2.0"

class ConsumerConan(ConanFile):
    name = "consumer"
    version = "0.1.0"

    settings = "os", "arch", "compiler", "build_type"
    requires = ("hello/0.1.0", "adder/0.1.0")
    generators = "CMakeDeps"

    def generate(self):
        tc = CMakeToolchain(self)
        tc.generate()
