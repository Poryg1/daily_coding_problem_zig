//Good morning! Here's your coding interview problem for today.
//This problem was asked by Stripe.
//Given an array of integers, find the first missing positive integer in linear time and constant space.
//In other words, find the lowest positive integer that does not exist in the array.
//The array can contain duplicates and negative numbers as well.
//For example, the input [3, 4, -1, 1] should give 2. The input [1, 2, 0] should give 3.
//You can modify the input array in-place.

//We could sort the entire array and then loop through it, but it's boring and in cases of generic unsorted arrays
//wasteful. So let's overcomplicate... I mean optimize it a bit.
//There are three possible alternatives.
//Either there is not a 1 in the array, in which case the lowest missing integer is 1, or there is 1 in the array.
//If the item is larger than the array's length, it means we've got an array of non-repeating consecutive integers starting from 1.
//In that case, the missing integer will be 1 higher than the array size.
//If there's at least one space or one repeating integer, the missing integer will never exceed the array size.
//Thus, we can discard any items higher than array size.
//And, we don't need to be sorting negative numbers, so we can discard them.

const std = @import("std");
pub fn main() void {
    var arr = [_]i32{ 9, 2, -1, 2, 6, 11, 13 };
    var index: usize = arr.len;
    //find first positive integer within range. Or don't if there isn't any, in which case we are finished :P
    for (0..arr.len) |i| {
        if (arr[i] > 0 and arr[i] <= arr.len) {
            index = i;
            break;
        }
    }
    if (index == arr.len) std.debug.print("Failed to find a small enough positive integer. The lowest missing positive integer is 1.", .{}) else {
        var smallerArray = arr[index..]; //We can safely ignore any numbers before our first found low enough integer.
        for (0..smallerArray.len) |i| {
            if (smallerArray[i] == 0) continue;
            while (smallerArray[i] != i + 1) {
                //Ignore zeroes
                if (smallerArray[i] == 0) break;
                //Get rid of negative, large or duplicate elements.
                if (smallerArray[i] < 0 or smallerArray[i] > smallerArray.len or smallerArray[i] == smallerArray[@intCast(smallerArray[i] - 1)]) {
                    smallerArray[i] = 0;
                    break;
                }
                //Swap sort is normally not the most efficient sorting algorithm, but for our purposes it's great as we 1. know the size of the items we're looking for and 2. will be discarding items in the process.
                var swap = smallerArray[@intCast(smallerArray[i] - 1)];
                smallerArray[@intCast(smallerArray[i] - 1)] = smallerArray[i];
                smallerArray[i] = swap;
            }
        }
        //And now that we have the array sorted and excess elements thrown away, let's loop through one last time and find the missing integer. But in case we don't find one due to it being a consecutive array, we have a backup.
        var missingNo: usize = smallerArray.len + 1;
        for (0..smallerArray.len) |i| {
            if (smallerArray[i] == 0) {
                missingNo = i + 1;
                break;
            }
        }
        std.debug.print("The smallest missing integer is {}", .{missingNo});
    }
}
