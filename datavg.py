class Mounts():
    """This class provides a way to store datavg objects for replay"""
    def __init__(self, thedatavg_dir_loc, thedatavg_name, thedatavg_size):
        self.thedatavg_dir_loc = datavg_dir_loc
        self.thethedatavg_name = datavg_name
        self.thethedatavg_size = datavg_size


class Groups():
    """"This class provides a way to store group creation for replay"""
    def __init__(self, thegroup_gid, thegroup_name):
        self.thegroup_gid = group_gid
        self.thegroup_name = group_name

class Users():
    """This class provides a way to store user objects for replay"""
    def __init__(self, theuser_name, theuser_uid, theuser_gid, theuser_group_name, theuser_home_dir, theuser_shell, theuser_gecos):
        self.theuser_name = user_name
        self.theuser_uid = user_uid
        self.theuser_gid = user_gid
        self.theuser_group_name = user_group_name
        self.theuser_home_dir = user_home_dir
        self.theuser_shell = user_shell
        self.theuser_gecos = user_gecos

