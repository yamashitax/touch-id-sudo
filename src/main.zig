const std = @import("std");

pub fn main() !void {
    const file = try std.fs.openFileAbsoluteZ("/etc/pam.d/sudo", .{ .mode = .read_write });
    defer file.close();

    const stat = file.stat();

    try file.writer().writeAll(
        \\# sudo: auth account password session
        \\auth       sufficient     pam_smartcard.so
        \\auth       sufficient     pam_tid.so
        \\auth       required       pam_opendirectory.so
        \\account    required       pam_permit.so
        \\password   required       pam_deny.so
        \\session    required       pam_permit.so,
    );
}
