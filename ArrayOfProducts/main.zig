//Good morning! Here's your coding interview problem for today.
//This problem was asked by Uber.
//Given an array of integers, return a new array such that each element at index i of the new array is the product of all
//the numbers in the original array except the one at i.
//For example, if our input was [1, 2, 3, 4, 5], the expected output would be [120, 60, 40, 30, 24].
//If our input was [3, 2, 1], the expected output would be [2, 3, 6].
//Follow-up: what if you can't use division?
const std = @import("std");

pub fn main() void {
    var beginArray = [_]u32{ 5, 4, 3, 2, 1 };
    if (beginArray.len < 2) { //A check to see if we have sufficient array length. In this code it makes no sense, but let's suppose we don't always have preset array :P
        std.debug.print("Insufficient array length!", .{});
    } else {
        var endArray: [beginArray.len]u32 = undefined; //We do not need to initialize the array, since we are 100% sure we don't do any math operations before we assign each element.
        endArray[0] = beginArray[1];
        for (2..beginArray.len) |i| endArray[0] *= beginArray[i]; //It's better to create a separate loop for the first and subsequent elements, since they behave a bit differently.
        for (1..beginArray.len) |i| {
            endArray[i] = beginArray[0];
            for (1..beginArray.len) |j| {
                if (i == j) {
                    continue;
                } else endArray[i] *= beginArray[j];
            }
        }
        std.debug.print("The final array from {any} is {any}", .{ beginArray, endArray });
    }
}
