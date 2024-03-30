using Sparlectra
using Test
using Logging

global_logger(ConsoleLogger(stderr, Logging.Warn))
include("testgrid.jl")
@testset "Sparlectra.jl" begin
  @test test3BusNet() == true
  @test testNetwork() == true
  @test test_NBI_MDO() == true
  @test test_acpflow(0) == true
#  @test testExportMatpower() == true does not run, can´t create testfile, add these test manually
#  @test testImportMatpower() == true 
#  @test rmTestfiles() == true 
end
