require 'spec_helper'

describe Mdm::Module::Action do
  context 'associations' do
    it { should belong_to(:module_instance).class_name('Mdm::Module::Instance') }
  end

  context 'database' do
    context 'columns' do
      it { should have_db_column(:module_instance_id).of_type(:integer).with_options(:null => false) }
      it { should have_db_column(:name).of_type(:text).with_options(:null => false) }
    end

    context 'indices' do
      it { should have_db_index([:module_instance_id, :name]).unique(true) }
    end
  end

  context 'factories' do
    context 'mdm_module_action' do
      subject(:mdm_module_action) do
        FactoryGirl.build(:mdm_module_action)
      end

      it { should be_valid }
    end
  end

  context 'mass assignment security' do
    it { should_not allow_mass_assignment_of(:module_instance_id) }
    it { should allow_mass_assignment_of(:name) }
  end

  context 'validations' do
    it { should validate_presence_of(:module_instance) }

    context 'name' do
      it { should validate_presence_of(:name) }

      it_should_behave_like 'validates uniqueness scoped to module_instance_id',
                            :of => :name,
                            :factory => :mdm_module_action,
                            :sequence => :mdm_module_action_name
    end
  end
end