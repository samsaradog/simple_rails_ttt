require "grid"

STATE_TO_VALUE = { :o_win => -1, :x_win => 1, :draw => 0, :open => 0 }

class TreeNode
  attr_reader :value, :move, :min, :max, :root, :depth
  
  def initialize(root,min,max,depth)
    @root, @min, @max, @depth = root, min, max, depth
    @value = STATE_TO_VALUE[root.state]
    @move_to_node = {}
    minimax() if (:open == root.state)
  end
  
  def minimax()
    @value = get_limit_value
        
    root.available.each do | next_move |
      node = new_child_node(root.dup.add!(token,next_move),min,max,(depth+1))
      @move_to_node[next_move] = node
      
      ( @value = node.value ) if need_to_change_value?(node)
      ( (@value = pruning_value) and break ) if value_at_limit?
    end
    
  end
  
  def best_move
    best_value = best_move_value
    return_move = @move_to_node.keys[0]
    
    @move_to_node.each do |current_move,node|
      return current_move if ( winning_state == node.root.state )
      if node_value_better?(node.value,best_value)
        return_move = current_move
        best_value = node.value
      end
    end
    return_move
  end
  
end

class MinNode < TreeNode
  
  def initialize(root, min=-1, max=1, depth=0)
    super(root,min,max,depth)
  end
  
  def get_limit_value
    max
  end
  
  def need_to_change_value?(node)
    node.value < value
  end
  
  def new_child_node(node,min,max,depth)
    MaxNode.new(node,min,value,depth)
  end
  
  def pruning_value
    min
  end
  
  def token
    O_TOKEN
  end
  
  def value_at_limit?
    return value < min if 0 == depth
    value <= min
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

  def initialize(root, min=-1, max=1,depth=0)
    super(root,min,max,depth)
  end
  
  def get_limit_value
    min
  end
  
  def need_to_change_value?(node)
    node.value > value
  end
  
  def new_child_node(node,min,max,depth)
    MinNode.new(node,value,max,depth)
  end
  
  def pruning_value
    max
  end
  
  def token
    X_TOKEN
  end
  
  def value_at_limit?
    return value > max if 0 == depth
    value >= max
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