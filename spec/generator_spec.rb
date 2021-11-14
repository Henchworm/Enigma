# require './lib/generator'
# require_relative './spec_helper'
#
# RSpec.describe Generator do
#   it "exists" do
#     generator = Generator.new
#     expect(generator).to be_a(Generator)
#   end
#
#   it "key generator" do
#     generator = Generator.new
#     range = Range.new(1,5)
#     expect(generator.key_generator).to be_a(String)
#     expect(generator.key_generator.length).to eq(5)
#     expect(range.include?(generator.key_generator.length)).to eq(true)
#   end
#
#   it "offset generator" do
#     generator = Generator.new
#     expect(generator.offset_generator(Date.new(1995,8,4))).to eq("1025")
#     expect(generator.offset_generator.length).to eq(4)
#     expect(generator.offset_generator("040895")).to eq("1025")
#   end
# end