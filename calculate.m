function f = foo(t,y)

%default parameters
a = 1;
b = 1;
m = 1.2;
n = 0.8;
%aggressiveness
r = 0.1;
s = 0.1;
%

%get parameters from gui
hGui = findobj('Tag','figure1');
if ~isempty(hGui)
    handles = guidata(hGui); 
    if isfield(handles,'edit1')
        temp = str2double(get(handles.edit1,'String'));
        if ~isnan(temp)
            a = temp;
        end
    end
    if isfield(handles,'edit2')
        temp = str2double(get(handles.edit2,'String'));
        if ~isnan(temp)
            b = temp;
        end
    end
    if isfield(handles,'edit3')
        temp = str2double(get(handles.edit3,'String'));
        if ~isnan(temp)
            m = temp;
        end
    end
    if isfield(handles,'edit4')
        temp = str2double(get(handles.edit4,'String'));
        if ~isnan(temp)
            n = temp;
        end
    end
    if isfield(handles,'edit5')
        temp = str2double(get(handles.edit5,'String'));
        if ~isnan(temp)
            r = temp;
        end
    end
    if isfield(handles,'edit6')
        temp = str2double(get(handles.edit6,'String'));
        if ~isnan(temp)
            s = temp;
        end
    end
end

f=[a*y(2)-m*y(1)+r;b*y(1)-n*y(2)+s];

end