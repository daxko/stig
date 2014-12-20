# 1.1.18 Disable Mounting of cramfs Filesystems
# The cramfs filesystem type is a compressed read-only Linux 
# filesystem embedded in small footprint systems. A cramfs 
# image can be used without having to first decompress the image.

# 1.1.19 Disable Mounting of freevxfs Filesystems
# The freevxfs filesystem type is a free version of the Veritas 
# type filesystem. This is the primary filesystem type for HP-UX 
# operating systems.

# 1.1.20 Disable Mounting of jffs2 Filesystems
# The jffs2 (journaling flash filesystem 2) filesystem type is 
# a log-structured filesystem used in flash memory devices.

# 1.1.21 Disable Mounting of hfs Filesystems
# The hfs filesystem type is a hierarchical filesystem that allows 
# you to mount Mac OS filesystems.

# 1.1.22 Disable Mounting of hfsplus Filesystems
# The hfsplus filesystem type is a hierarchical filesystem designed 
# to replace hfs that allows you to mount Mac OS filesystems.

# 1.1.23 Disable Mounting of squashfs Filesystems
# The squashfs filesystem type is a compressed read-only Linux filesystem 
# embedded in small footprint systems (similar to cramfs). A squashfs 
# image can be used without having to first decompress the image.

# 1.1.24 Disable Mounting of udf Filesystems
# The udf filesystem type is the universal disk format used to implement 
# ISO/IEC 13346 and ECMA-167 specifications. This is an open vendor 
# filesystem type for data storage on a broad range of media. This 
# filesystem type is necessary to support writing DVDs and newer optical 
# disc formats.

template "/etc/modprobe.d/CIS.conf" do
  source "CIS.conf.erb"
  owner "root"
  group "root"
  mode 0644
end