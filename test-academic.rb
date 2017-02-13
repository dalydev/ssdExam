require 'minitest/autorun'
require_relative 'academic'

class TestSubject < MiniTest::Test
  def setup
    @subject = Subject.new 'Module 1',2,5
    @topic1 = Topic.new(6,"topic 1") ;
    @topic2 = Topic.new(7,"topic 2") ;
    @topic3 = Topic.new(5,"topic 3") ;;
  end

  def teardown
      @subject = @topic1 = @topic2 = @topic3 = nil
  end
  
  def test_find_topic
      addSomeTopics
      # Normal
      result = @subject.findTopic 'topic 2'
      assert_equal @topic2, result
      result = @subject.findTopic 'topic 4'
      assert_nil result
   end

  def test_add_topic
        # Normal
        result = @subject.addTopic @topic1
        assert result
        assert_equal @topic1, @subject.findTopic('topic 1')
        # Extra setup
        @subject.addTopic @topic2
        @subject.addTopic @topic3        
        # Error
        topic4 = Topic.new 20, 'topic 4'
        result = @subject.addTopic topic4
        assert_equal false, result
        result = @subject.findTopic 'topic 4'
        assert_nil result
        # Boundry
        topic4 = Topic.new 6, 'topic 4'
        result = @subject.addTopic topic4
        assert result
        assert_equal topic4, @subject.findTopic('topic 4')
   end
   
   def test_remove_topic
     addSomeTopics
     # Normal
     result = @subject.removeTopic 'topic 1'
     assert result
     assert_nil @subject.findTopic 'topic 1'
     result = @subject.removeTopic 'topic X'
     assert_equal false, result
   end

   def test_merge_topics
     addSomeTopics
     # Normal
     result = @subject.findTopic 'topic 1'
     assert result
     result = @subject.findTopic 'topic 2'
     assert result
     @subject.mergeTopics 'topic 1','topic 2', 'new topic'
     result = @subject.findTopic 'new topic'
     assert result
     result = @subject.findTopic 'topic 1'
     assert_nil result
     result = @subject.findTopic 'topic 2'
     assert_nil result

     result = @subject.findTopic('new topic').noLectures = 13 # merged @topic1 (6 lectures) with @topic2 (7 lectures)
     assert result
     
   end

   def test_other_method
     # Normal
     # case 1
     # case 1
     # Error
     # case 1
     # case 1
     # Boundry
     # case 1  
   end

   def addSomeTopics
      @subject.addTopic @topic1
      @subject.addTopic @topic2
      @subject.addTopic @topic3
  end
end