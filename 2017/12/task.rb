
class Plumber
    attr_accessor :map, :groups

    def initialize(map)
        @map = parse(map)
        @groups = {}
    end

    def build_group(node)
        connect_node_to_group(node, node)
    end

    def count_group_members(group)
        groups[group].length
    end

    def group_all
        grouped_nodes = []
        map.keys.each do |node|
            next if grouped_nodes.include?(node)
            build_group(node)
            grouped_nodes += groups[node]
        end
    end

    def count_groups
        groups.keys.length
    end

    def connect_node_to_group(node, group)
        @groups[group] = [] unless @groups[group]
        return if @groups[group].include?(node)
        @groups[group] << node
        return unless @map[node]
        @map[node].each { |connection| connect_node_to_group(connection, group) }
    end

    def parse(data)
        res = {}
        data.each do |row|
            parts = row.gsub(/\s+/m, '').split('<->')
            res[parts[0]] = parts[1] ? parts[1].split(',') : []
        end
        res
    end
end
