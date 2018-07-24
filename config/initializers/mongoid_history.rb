# Initializer for mongoid-history
# Mongoid::History will use the first loaded class to include Mongoid::History::Tracker as the default history tracker
Mongoid::History.tracker_class_name = :history_tracker
Mongoid::History.modifier_class_name = 'User'
