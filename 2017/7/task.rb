class RecursiveTree
    attr_accessor :data, :nodes, :root
    def initialize(data)
        @data = data
        @nodes = {}
        map_data
    end

    def find_root
        return root if root
        parents = []
        children = []
        nodes.each do |key, node|
            parents << node.name
            children += node.children
        end
        @root = nodes[(parents - children).first]
    end

    def build_tree(node = nil)
        node = find_root unless node
        node.children = node.children.map do |child_name|
            child = build_tree(nodes[child_name])
            child.parent = node
            child
        end
        node
    end

    def find_correct_weight
        node = find_unbalanced_node
        parent = node.parent
        actual_weight = node.total_weight
        expected_weigth = parent.children[0].total_weight == actual_weight ? parent.children[1].total_weight : parent.children[0].total_weight
        node.weight + expected_weigth - actual_weight
    end

    def find_unbalanced_node(node = nil)
        node = find_root unless node
        child = node.find_unbalanced_child
        return node unless child
        find_unbalanced_node(child)
    end

    private

    def map_data
        data.each do |row|
            node = Program.new(row)
            nodes[node.name] = node
        end
    end
end


class Program
    attr_accessor :weight, :children, :name, :parent
    def initialize(string)
        parts = string.gsub(/\s+/m, '').split('->')
        node_data = parts.first.split('(')
        @name = node_data.first
        @weight = node_data[1].to_i
        @children = parts[1] ? parts[1].split(',').map(&:strip) : []
    end

    def is_balanced?
        children.map(&:total_weight).uniq.length <= 1
    end

    def total_weight
        @total_weight ||= weight + children.inject(0) { |s, e| s + e.total_weight }
    end

    def find_unbalanced_child
        return nil if is_balanced?
        child_weigths = {}
        children.each do |child|
            child_weigths[child.total_weight] ||= []
            child_weigths[child.total_weight] << child
        end
        child_weigths.each do |weight, nodes|
            return nodes.first if nodes.length == 1
        end
    end
end