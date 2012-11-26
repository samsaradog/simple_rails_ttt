require "grid"

STATE_TO_VALUE = { :o_win => -1, :x_win => 1, :draw => 0, :open => 0 }

class TreeNode
  attr_reader :value, :move, :min, :max, :root
  
  def initialize(root,min,max)
    @root, @min, @max = root, min, max
    @value = STATE_TO_VALUE[root.state]
    minimax() if (:open == root.state)
  end
  
  def minimax()
    @value = get_limit_value
    
    move_to_node = {}
    
    root.available.each do | next_move |
      node = new_child_node(root.dup.add!(token,next_move),min,max)
      move_to_node[next_move] = node
      
      ( @value = node.value ) if need_to_change_value?(node)
      ( (@value = pruning_value) and break ) if value_at_limit?
    end
    
    @move = best_move(move_to_node)
  end
  
  def best_move(move_to_node)
    best_value = best_move_value
    return_move = move_to_node.keys[0]
    
    move_to_node.each do |move,node|
      return move if ( winning_state == node.root.state )
      if node_value_better?(node.value,best_value)
        return_move = move
        best_value = node.value
      end
    end
    return_move
  end
  
end

class MinNode < TreeNode
  
  def initialize(root, min=-1, max=1)
    super(root,min,max)
  end
  
  def get_limit_value
    max
  end
  
  def need_to_change_value?(node)
    node.value < value
  end
  
  def new_child_node(node,min,max)
    MaxNode.new(node,min,value)
  end
  
  def pruning_value
    min
  end
  
  def token
    O_TOKEN
  end
  
  def value_at_limit?
    value < min
  end
  
  def best_move_value
    STATE_TO_VALUE[:x_win]
  end
  
  def winning_state
    :o_win
  end
  
  def node_value_better?(node_value, best_value)
    (node_value < best_value)
  end
  
end

class MaxNode < TreeNode

  def initialize(root, min=-1, max=1)
    super(root,min,max)
  end
  
  def get_limit_value
    min
  end
  
  def need_to_change_value?(node)
    node.value > value
  end
  
  def new_child_node(node,min,max)
    MinNode.new(node,value,max)
  end
  
  def pruning_value
    max
  end
  
  def token
    X_TOKEN
  end
  
  def value_at_limit?
    value > max
  end
  
  def best_move_value
    STATE_TO_VALUE[:o_win]
  end
  
  def winning_state
    :x_win
  end
  
  def node_value_better?(node_value, best_value)
    (node_value > best_value)
  end
  
end