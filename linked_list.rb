# frozen_string_literal: true

# Node for linked list, containing a value and a link to the next element.
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

# linked list, with head by default
class LinkedList
  attr_accessor :head

  def initialize
    @head = Node.new('head')
  end

  def append(value, node = head)
    if node.next_node.nil?
      node.next_node = Node.new(value)
    else
      append(value, node.next_node)
    end
  end

  def prepend(value)
    old_next_node = head.next_node
    head.next_node = Node.new(value)
    head.next_node.next_node = old_next_node
  end

  def size(count = -1, node = head)
    count += 1
    return count if node.next_node.nil?

    size(count, node.next_node)
  end

  def tail(node = head)
    return node if node.next_node.nil?

    tail(node.next_node)
  end

  def at(index, curr_index = -1, node = head)
    return node if curr_index == index

    at(index, curr_index + 1, node.next_node)
  end

  def pop(node = head)
    return if head.next_node.nil?

    if node.next_node.next_node.nil?
      node.next_node = nil
    else
      pop(node.next_node)
    end
  end

  def contains?(value, node = head)
    return true if node.value == value
    return false if node.next_node.nil?

    contains?(value, node.next_node)
  end

  def find(value, node = head, curr_index = -1)
    return nil if node.nil?
    return curr_index if node.value == value

    find(value, node.next_node, curr_index + 1)
  end

  def to_s(node = head, final_string = '')
    return "#{final_string}nil" if node.nil?

    to_s(node.next_node, final_string + "( #{node.value} ) -> ")
  end

  def insert_at(value, index, node = head, curr_index = -1)
    return if node.nil?

    if curr_index == index - 1
      old_next_node = node.next_node
      node.next_node = Node.new(value, old_next_node)
    end

    insert_at(value, index, node.next_node, curr_index + 1)
  end

  def remove_at(index, node = head, curr_index = -1)
    return if node.nil?

    if index - 1 == curr_index
      new_next_node = node.next_node.next_node
      node.next_node = new_next_node
    end

    remove_at(index, node.next_node, curr_index + 1)
  end
end

my_linked_list = LinkedList.new
my_linked_list.append('peanuts')
my_linked_list.append('butter')
my_linked_list.prepend('sandwich')

puts my_linked_list.size
my_linked_list.pop
puts my_linked_list.size
puts my_linked_list.contains?('peanuts')
puts my_linked_list.contains?('butter')
puts my_linked_list.find('sandwich')
puts my_linked_list.find('hi')
puts my_linked_list.to_s

my_linked_list.insert_at('potato', 1)
puts my_linked_list.to_s
my_linked_list.remove_at(1)
puts my_linked_list.to_s
