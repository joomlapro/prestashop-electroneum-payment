{*
* NOTICE OF LICENSE
*
* The MIT License (MIT)
*
* Copyright (c) 2015-2018 JoomlaPro
*
* Permission is hereby granted, free of charge, to any person obtaining a copy of
* this software and associated documentation files (the "Software"), to deal in
* the Software without restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so, subject
* to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
* IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*
*  @author    JoomlaPro <info@joomlapro.com>
*  @copyright 2015-2018 JoomlaPro

*}

<div id="title">
  <h2 style="text-align:center;">Pay and Confirm Your order</h2>

    <table class="table table-striped" style="max-width:420px; margin:0 auto; text-align:center;">
      <tr>
       <td>{l s='Amount' d='Modules.Electroneum.Shop'} :
       	{$orderTotal}</td>
      </tr>
      <tr>
      <td>{l s='ETN Value' d='Modules.Electroneum.Shop'} :
       {$etnTotal}</td>
    </tr>
   </table>

</div>

<div id="payments_electroneum" style="margin-top:15px;">
<form class="uk-form uk-form-horizontal uk-text-center" style=" text-align:center;" id="electronium_payform" method="post" action="">
            

			<div id="paymentqr_div">
				<div class="uk-form-row">
                    <p class='uk-text-primary uk-text-large uk-text-bold'>Payment for {$etnvalue} ETN to outlet</p>
                    
                    <div class="uk-text-center uk-margin-bottom" style="background-color: rgb(255, 255, 255); margin:0 auto; padding-bottom: 5px; border-color: rgb(255, 255, 255); border-style: solid; border-width: 12px 12px 6px; border-image: none 100% / 1 / 0 stretch; border-radius: 8px; box-shadow: rgba(50, 50, 50, 0.2) 0px 2px 8px 0px; width: 240px; text-decoration: none; color: rgb(51, 51, 51); text-align: center; cursor: pointer;">
        
                        <div style="position: relative; box-sizing: content-box; border: 1px solid #24aaca;">
                             <img id='qrimage' src="{$qrImgUrl}" style='box-sizing: border-box; border: 8px solid rgb(255, 255, 255); margin-bottom: 10px; width: 100%;' />"; 
                             <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDIyLjEuMCwgU1ZHIEV4cG9ydCBQbHVnLUluIC4gU1ZHIFZlcnNpb246IDYuMDAgQnVpbGQgMCkgIC0tPgo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IgoJIHZpZXdCb3g9IjAgMCAxMTg1LjQgMjYwLjMiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDExODUuNCAyNjAuMzsiIHhtbDpzcGFjZT0icHJlc2VydmUiPgo8c3R5bGUgdHlwZT0idGV4dC9jc3MiPgoJLnN0MHtmaWxsOiMwQzM1NDg7fQoJLnN0MXtmaWxsOiMyQUIxRjM7fQo8L3N0eWxlPgo8dGl0bGU+YWx0LWNvbG91cnM8L3RpdGxlPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNMzk5LjcsMTE5LjJ2MjYuNGgtNjMuOXYxNi4xYzAuMSwyLjcsMi4yLDQuOCw0LjksNC45aDU5djEwLjNoLTU5Yy04LjQsMC0xNS4yLTYuOC0xNS4yLTE1LjJjMCwwLDAsMCwwLDAKCXYtNDIuNWMwLTguNCw2LjgtMTUuMiwxNS4yLTE1LjJjMCwwLDAsMCwwLDBoNDMuN0MzOTIuOCwxMDMuOSwzOTkuNiwxMTAuNywzOTkuNywxMTkuMkMzOTkuNywxMTkuMSwzOTkuNywxMTkuMSwzOTkuNywxMTkuMnoKCSBNMzg5LjIsMTM1LjN2LTE2LjFjMC0yLjctMi4yLTQuOS00LjktNC45aC00My43Yy0yLjcsMC4xLTQuOCwyLjItNC45LDQuOXYxNi4xSDM4OS4yeiIvPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNNDIwLjIsODAuMnY4MS41YzAuMSwyLjcsMi4yLDQuOCw0LjksNC45aDEyLjN2MTAuM2gtMTIuM2MtOC40LDAtMTUuMi02LjgtMTUuMi0xNS4yYzAsMCwwLDAsMCwwVjgwLjJINDIwLjJ6IgoJLz4KPHBhdGggY2xhc3M9InN0MCIgZD0iTTUyMCwxMTkuMnYyNi40aC02My45djE2LjFjMC4xLDIuNywyLjIsNC44LDQuOSw0LjloNTl2MTAuM2gtNTljLTguNCwwLTE1LjItNi44LTE1LjItMTUuMmMwLDAsMCwwLDAsMHYtNDIuNQoJYzAtOC40LDYuOC0xNS4yLDE1LjItMTUuMmMwLDAsMCwwLDAsMGg0My43QzUxMy4xLDEwMy45LDUyMCwxMTAuNyw1MjAsMTE5LjJDNTIwLDExOS4xLDUyMCwxMTkuMSw1MjAsMTE5LjJ6IE01MDkuNywxMzUuM3YtMTYuMQoJYzAtMi43LTIuMi00LjktNC45LTQuOWgtNDMuN2MtMi43LDAuMS00LjgsMi4yLTQuOSw0Ljl2MTYuMUg1MDkuN3oiLz4KPHBhdGggY2xhc3M9InN0MCIgZD0iTTYwNC40LDE2Ni42djEwLjNoLTU5Yy04LjQsMC0xNS4yLTYuOC0xNS4yLTE1LjJjMCwwLDAsMCwwLDB2LTQyLjVjMC04LjQsNi44LTE1LjIsMTUuMi0xNS4yYzAsMCwwLDAsMCwwaDU4LjgKCXYxMC4zaC01OC44Yy0yLjcsMC4xLTQuOCwyLjItNC45LDQuOXY0Mi41YzAuMSwyLjcsMi4yLDQuOCw0LjksNC45TDYwNC40LDE2Ni42eiIvPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNNjI0LjksMTE0LjN2NDcuM2MwLjEsMi43LDIuMiw0LjgsNC45LDQuOWgyNi42djEwLjNoLTI2LjZjLTguNCwwLTE1LjEtNi44LTE1LjItMTUuMWMwLDAsMC0wLjEsMC0wLjFWODAuMQoJSDYyNVYxMDRoMzEuNXYxMC4zTDYyNC45LDExNC4zeiIvPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNNzIyLjEsMTA0djEwLjNoLTQwLjljLTIuNywwLjEtNC44LDIuMi00LjksNC45djU3LjZINjY2di01Ny42YzAtOC40LDYuOC0xNS4yLDE1LjItMTUuMmMwLDAsMCwwLDAsMEg3MjIuMXoiCgkvPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNNzg4LjQsMTA0YzguNCwwLDE1LjMsNi43LDE1LjMsMTUuMWMwLDAsMCwwLDAsMC4xdjQyLjVjMCw4LjQtNi44LDE1LjItMTUuMiwxNS4yYzAsMCwwLDAtMC4xLDBoLTQzLjcKCWMtOC40LDAtMTUuMi02LjgtMTUuMi0xNS4yYzAsMCwwLDAsMCwwdi00Mi41YzAtOC40LDYuOC0xNS4yLDE1LjItMTUuMmMwLDAsMCwwLDAsMEg3ODguNHogTTc0NC43LDExNC4zYy0yLjcsMC4xLTQuOCwyLjItNC45LDQuOQoJdjQyLjVjMC4xLDIuNywyLjIsNC44LDQuOSw0LjloNDMuN2MyLjcsMCw0LjktMi4yLDQuOS00Ljl2LTQyLjVjMC0yLjctMi4yLTQuOS00LjktNC45TDc0NC43LDExNC4zeiIvPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNODg5LjEsMTE5LjJ2NTcuNmgtMTAuM3YtNTcuNmMtMC4xLTIuNy0yLjItNC44LTQuOS00LjloLTQzLjdjLTIuNywwLTQuOSwyLjItNSw0Ljl2NTcuNmgtMTAuM1YxMDRoNTkKCWM4LjQsMCwxNS4yLDYuNywxNS4yLDE1LjFDODg5LjEsMTE5LjEsODg5LjEsMTE5LjEsODg5LjEsMTE5LjJ6Ii8+CjxwYXRoIGNsYXNzPSJzdDAiIGQ9Ik05NzYuMiwxMTkuMnYyNi40aC02My45djE2LjFjMC4xLDIuNywyLjIsNC44LDQuOSw0LjloNTl2MTAuM2gtNTljLTguNCwwLTE1LjItNi44LTE1LjItMTUuMmMwLDAsMCwwLDAsMAoJdi00Mi41YzAtOC40LDYuOC0xNS4yLDE1LjItMTUuMmMwLDAsMCwwLDAsMGg0My43Qzk2OS4zLDEwMy45LDk3Ni4yLDExMC43LDk3Ni4yLDExOS4yQzk3Ni4yLDExOS4xLDk3Ni4yLDExOS4xLDk3Ni4yLDExOS4yegoJIE05NjUuOCwxMzUuM3YtMTYuMWMwLTIuNy0yLjItNC45LTQuOS00LjloLTQzLjdjLTIuNywwLjEtNC44LDIuMi00LjksNC45djE2LjFIOTY1Ljh6Ii8+CjxwYXRoIGNsYXNzPSJzdDAiIGQ9Ik0xMDYzLjMsMTA0djU3LjZjMCw4LjQtNi44LDE1LjItMTUuMiwxNS4yYzAsMCwwLDAtMC4xLDBoLTQzLjdjLTguNCwwLTE1LjItNi44LTE1LjItMTUuMmMwLDAsMCwwLDAsMFYxMDQKCWgxMC4zdjU3LjZjMC4xLDIuNywyLjIsNC44LDQuOSw0LjloNDMuN2MyLjcsMCw0LjktMi4yLDUtNC45VjEwNEgxMDYzLjN6Ii8+CjxwYXRoIGNsYXNzPSJzdDAiIGQ9Ik0xMTg1LjQsMTE5LjJ2NTcuNmgtMTAuMnYtNTcuNmMtMC4xLTIuNy0yLjMtNC45LTUtNC45aC0zMC4zYy0yLjcsMC00LjksMi4yLTQuOSw0Ljl2NTcuNmgtMTAuM3YtNTcuNgoJYy0wLjEtMi43LTIuMi00LjgtNC45LTQuOWgtMzAuNGMtMi43LDAuMS00LjgsMi4yLTQuOSw0Ljl2NTcuNmgtMTAuNFYxMDRoOTYuMmM4LjMsMCwxNS4xLDYuNywxNS4yLDE1CglDMTE4NS40LDExOSwxMTg1LjQsMTE5LjEsMTE4NS40LDExOS4yeiIvPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNMTc1LjksMTAwLjNsMjEuNiwxNi40bDEzLjcsMTAuM2wtMTUuMiw3LjhsLTMwLjcsMTUuN2wxMC41LDcuM2wxNC43LDEwLjJsLTE1LjksOC4ybC05Ny41LDUwLjMKCWM1My4xLDI5LjIsMTE5LjksOS45LDE0OS4xLTQzLjNjMjEuOC0zOS42LDE3LjEtODguNS0xMS45LTEyMy4yTDE3NS45LDEwMC4zeiIvPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNODQuMSwxNjUuOGwtMjEuNi0xNi40bC0xMy43LTEwLjNsMTUuMi03LjhsMzAuNy0xNS43bC0xMC41LTcuM0w2OS41LDk4LjFsMTUuOS04LjJsMTAyLjctNTMKCUMxMzYuNyw0LjgsNjguOSwyMC41LDM2LjksNzEuOUMxMSwxMTMuNCwxNS43LDE2Nyw0OC4zLDIwMy40TDg0LjEsMTY1Ljh6Ii8+CjxwYXRoIGNsYXNzPSJzdDAiIGQ9Ik00MS43LDIxMC42Qy0yLjgsMTYxLjgsMC44LDg2LjIsNDkuNSw0MS44QzkwLjcsNC4zLDE1Mi4zLDAuMiwxOTguMSwzMmwxMC43LTUuNUMxNTEuNS0xNyw2OS45LTUuOCwyNi40LDUxLjUKCWMtMzguMSw1MC4yLTM0LjcsMTIwLjUsOCwxNjYuOUw0MS43LDIxMC42eiIvPgo8cGF0aCBjbGFzcz0ic3QwIiBkPSJNMjIxLDUyLjhjNDIuOCw1MC4yLDM2LjgsMTI1LjYtMTMuNCwxNjguNGMtMzkuNiwzMy43LTk2LjUsMzgtMTQwLjcsMTAuNEw1NiwyMzcuMgoJYzU5LjEsNDAuOSwxNDAuMSwyNi4yLDE4MS4xLTMyLjljMzMuOC00OC44LDMwLjMtMTE0LjQtOC43LTE1OS4zTDIyMSw1Mi44eiIvPgo8cG9seWdvbiBjbGFzcz0ic3QxIiBwb2ludHM9IjY4LjksMTQwLjkgMTAwLjEsMTY0LjUgMjkuNiwyMzguOCAxNjkuNywxNjYuNSAxNDQuNCwxNDkuMSAxOTEuMSwxMjUuMiAxNTkuOCwxMDEuNiAyMzAuMywyNy40IAoJOTAuMyw5OS42IDExNS42LDExNy4xICIvPgo8L3N2Zz4K" style="width: 110px; box-sizing: content-box; background-color: rgb(255, 255, 255); padding: 0px 8px; position: absolute; bottom: -13px; left: 50%; transform: translateX(-50%);">
                       </div>
                      <img src="{$loadingimg}" style="height:55px; margin-top:10px;" />
                      <div>Scan with the app or click to pay</div>
        
                   </div>
               </div>
               <div id="error_div" style="color:#ff0000; margin:25px 0;">
               </div>
				
                <div class="" style="margin:20px 0;">
                	<button type="button" onclick="checkelectroneumresponse()" class="btn btn-primary btn-lg">Confirm</button>
                </div>	
			</div>
			
			
            
           <div id="thirddiv" style="display:none;">
			 <svg id="checkmark_svg" style="display:none;" class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52"><circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/><path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/></svg>
		   </div>
			
            <input type="hidden" name="currencycode" value="{$currencycode}" id="currencycode" />
		    <input type="hidden" name="ajaxlink" id="ajaxlink" value="{$ajax_link}" /> 
			<input type="hidden" name="etn" id="etn" value="{$etnvalue}" /> 
			<input type="hidden" name="paymentid" id="paymentid" value="{$etnpaymentid}" /> 
			<input type="hidden" name="apikey" id="apikey" value="{$apikey}" />
			<input type="hidden" name="secret" id="secret" value="{$secret}" />
			<input type="hidden" name="outlet" id="outlet" value="{$outlet}" />
            <input type="hidden" name="id_order" id="id_order" value="{$id_order}" />
			<input type="hidden" name="ajaxtask" id="ajaxtask" value="getresponse" />
            
			<input type="submit" name="submit_btn" value="submitbtn" style="display:none;" />
	</form>
</div>
