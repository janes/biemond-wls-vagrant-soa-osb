newproperty(:autoextend) do
  include EasyType

  desc "Enable autoextension for the tablespace"
  newvalues(:on, :off)

  to_translate_to_resource do | raw_resource|
    case raw_resource.column_data('AUT')
    when 'YES' then :on
    when 'NO' then :no
    else
      fail('Invalid autoxtend found in tablespace resource.')
    end
  end

  on_apply do | command_builder|
    "autoextend #{resource[:autoextend]}"
  end
end
