//Good morning! Here's your coding interview problem for today.
//This problem was recently asked by Google.
//Given a list of numbers and a number k, return whether any two numbers from the list add up to k.
//For example, given [10, 15, 3, 7] and k of 17, return true since 10 + 7 is 17.
//Bonus: Can you do this in one pass?

//Idk what they mean by "in one pass", but whatever. Let's see.
const std = @import("std");

pub fn addsToK(arr: []u32, finalNum: u32) void {
    for (arr, 0..) |num, i| { // We could be lazy and omit the second parameter. However, then we'd be iterating through combinations we've already tried. Lazy & inefficient!
        for (arr[i..]) |num2| {
            if (num + num2 == finalNum) {
                std.debug.print("There is at least 1 combo of numbers that add up to {d}", .{finalNum});
                return;
            }
        }
    }
    std.debug.print("No variables add to {}", .{finalNum});
}

pub fn main() void {
    var inputNumbers = [_]u32{ 1, 6, 8, 10, 11, 13, 17, 19, 21, 25 };
    var finalNumber: u32 = 30;
    addsToK(&inputNumbers, finalNumber);
}
