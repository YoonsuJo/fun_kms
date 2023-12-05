/*!
 * jQuery CheckboxTree
 *
 * @author Valerio Galano <v.galano@daredevel.it>
 *
 * @see http://checkboxtree.daredevel.it
 *
 * @version 0.5.2
 */
$.widget("daredevel.checkboxTree", {

    /**
     * Check if all descendant of passed node are checked
     *
     * @private
     *
     * @param li node
     *
     * @return true if all descendant checked
     */
    _allDescendantChecked: function(li) {
        return (li.find('li input:checkbox:not(:checked)').length == 0);
    },

    /**
     * Initialize plugin
     *
     * @private
     */
    _create: function() {

        var t = this;

        // setup collapse engine tree
        if (this.options.collapsable) {

            // build collapse engine's anchors
            this.options.collapseAnchor = (this.options.collapseImage.length > 0) ? '<img src="' + this.options.collapseImage + '" />' : '';
            this.options.expandAnchor = (this.options.expandImage.length > 0) ? '<img src="' + this.options.expandImage + '" />' : '';
            this.options.leafAnchor = (this.options.leafImage.length > 0) ? '<img src="' + this.options.leafImage + '" />' : '';

            // initialize leafs
            this.element.find("li:not(:has(ul))").each(function() {
                $(this).prepend($('<span />'));
                t._markAsLeaf($(this));
            });

            // initialize checked nodes
            this.element.find("li:has(ul):has(input:checkbox:checked)").each(function() {
                $(this).prepend($('<span />'));
                t.options.initializeChecked == 'collapsed' ? t.collapse($(this)) : t.expand($(this));
            });

            // initialize unchecked nodes
            this.element.find("li:has(ul):not(:has(input:checkbox:checked))").each(function() {
                $(this).prepend($('<span />'));
                t.options.initializeUnchecked == 'collapsed' ? t.collapse($(this)) : t.expand($(this));
            });

            // bind collapse/expand event
            this.element.find('li span').live("click", function() {
                var li = $(this).parents("li:first");

                if (li.hasClass('collapsed')) {
                    t.expand(li);
                } else

                if (li.hasClass('expanded')) {
                    t.collapse(li);
                }
            });

            // bind collapse all element event
            $(this.options.collapseAllElement).bind("click", function() {
                t.collapseAll();
            });

            // bind expand all element event
            $(this.options.expandAllElement).bind("click", function() {
                t.expandAll();
            });

            // bind collapse on uncheck event
            if (this.options.onUncheck.node == 'collapse') {
                this.element.find('input:checkbox:not(:checked)').live("click", function() {
                    t.collapse($(this).parents("li:first"));
                });
            } else

            // bind expand on uncheck event
            if (this.options.onUncheck.node == 'expand') {
                this.element.find('input:checkbox:not(:checked)').live("click", function() {
                    t.expand($(this).parents("li:first"));
                });
            }

            // bind collapse on check event
            if (this.options.onCheck.node == 'collapse') {
                this.element.find('input:checkbox:checked').live("click", function() {
                    t.collapse($(this).parents("li:first"));
                });
            } else

            // bind expand on check event
            if (this.options.onCheck.node == 'expand') {
                this.element.find('input:checkbox:checked').live("click", function() {
                    t.expand($(this).parents("li:first"));
                });
            }
        }

        // bind node uncheck event
        this.element.find('input:checkbox:not(:checked)').live('click', function() {
            var li = $(this).parents('li:first');
            t.uncheck(li);
        });

        // bind node check event
        this.element.find('input:checkbox:checked').live('click', function() {
            var li = $(this).parents('li:first');
            t.check(li);
        });

        // add essential css class
        this.element.addClass('ui-widget-daredevel-checkboxTree');

        // add jQueryUI css widget class
        this.element.addClass('ui-widget ui-widget-content');

    },

    /**
     * Check ancestors on passed node
     *
     * Don't use check() method because we won't trigger onCheck events
     *
     * @private
     *
     * @param li node
     */
    _checkAncestors: function(li) {
        li.parentsUntil(".ui-widget").filter('li').find('input:checkbox:first:not(:checked)').attr('checked', true).change();
    },

    /**
     * Check descendants on passed node
     *
     * Don't use check() method because we won't trigger onCheck events
     *
     * @private
     *
     * @param li node
     */
    _checkDescendants: function(li) {
        li.find('li input:checkbox:not(:checked)').attr('checked', true).change();
    },

    /**
     * Check nodes that are neither ancestors or descendants of passed node
     *
     * Don't use check() method because we won't trigger onCheck events
     *
     * @private
     *
     * @param li node
     */
    _checkOthers: function(li) {
        li.addClass('exclude');
        li.parents('li').addClass('exclude');
        li.find('li').addClass('exclude');
        $(this.element).find('li').each(function() {
            if (!$(this).hasClass('exclude')) {
                $(this).find('input:checkbox:first:not(:checked)').attr('checked', true).change();
            }
        });
        $(this.element).find('li').removeClass('exclude');
    },

    /**
     * Destroy plugin
     *
     * @private
     */
    _destroy: function() {
        this.element.removeClass(this.options.cssClass);

        $.Widget.prototype.destroy.call(this);
    },

    /**
     * Check if passed node is a root
     *
     * @private
     *
     * @param li node to check
     */
    _isRoot: function(li) {
        var parents = li.parentsUntil('.ui-widget-daredevel-checkboxTree');
        return 0 == parents.length;
    },

    /**
     * Mark node as collapsed
     *
     * @private
     *
     * @param li node to mark
     */
    _markAsCollapsed: function(li) {
        if (this.options.expandAnchor.length > 0) {
            li.children("span").html(this.options.expandAnchor);
        } else
        if (this.options.collapseUiIcon.length > 0) {
            li.children("span").removeClass(this.options.expandUiIcon).addClass('ui-icon ' + this.options.collapseUiIcon);
        }
        li.removeClass("expanded").addClass("collapsed");
    },

    /**
     * Mark node as expanded
     *
     * @private
     *
     * @param li node to mark
     */
    _markAsExpanded: function(li) {
        if (this.options.collapseAnchor.length > 0) {
            li.children("span").html(this.options.collapseAnchor);
        } else
        if (this.options.expandUiIcon.length > 0) {
            li.children("span").removeClass(this.options.collapseUiIcon).addClass('ui-icon ' + this.options.expandUiIcon);
        }
        li.removeClass("collapsed").addClass("expanded");
    },

    /**
     * Mark node as leaf
     *
     * @private
     *
     * @param li  node to mark
     */
    _markAsLeaf: function(li) {
        if (this.options.leafAnchor.length > 0) {
            li.children("span").html(this.options.leafAnchor);
        } else
        if (this.options.leafUiIcon.length > 0) {
            li.children("span").addClass('ui-icon ' + this.options.leafUiIcon);
        }
        li.addClass("leaf");
    },

    /**
     * Return parent li of the passed li
     *
     * @private
     *
     * @param li node
     *
     * @return parent li
     */
    _parentNode: function(li) {
        return li.parents('li:first');
    },

    /**
     * Uncheck ancestors of passed node
     *
     * Don't use uncheck() method because we won't trigger onUncheck events
     *
     * @private
     *
     * @param li node
     */
    _uncheckAncestors: function(li) {
        li.parentsUntil(".ui-widget").filter('li').find('input:checkbox:first:checked').attr('checked', false).change();
    },

    /**
     * Uncheck descendants of passed node
     *
     * Don't use uncheck() method because we won't trigger onUncheck events
     *
     * @private
     *
     * @param li node
     */
    _uncheckDescendants: function(li) {
        li.find('li input:checkbox:checked').attr('checked', false).change();
    },

    /**
     * Uncheck nodes that are neither ancestors or descendants of passed node
     *
     * Don't use uncheck() method because we won't trigger onUncheck events
     *
     * @private
     *
     * @param li node
     */
    _uncheckOthers: function(li) {
        li.addClass('exclude');
        li.parents('li').addClass('exclude');
        li.find('li').addClass('exclude');
        $(this.element).find('li').each(function() {
            if (!$(this).hasClass('exclude')) {
                $(this).find('input:checkbox:first:checked').attr('checked', false).change();
            }
        });
        $(this.element).find('li').removeClass('exclude');
    },

    /**
     * Check node
     *
     * @public
     *
     * @param li node to check
     */
    check: function(li) {

        li.find('input:checkbox:first:not(:checked)').attr('checked', true).change();

        // handle others
        if (this.options.onCheck.others == 'check') {
            this._checkOthers(li);
        } else

        if (this.options.onCheck.others == 'uncheck') {
            this._uncheckOthers(li);
        }

        // handle descendants
        if (this.options.onCheck.descendants == 'check') {
            this._checkDescendants(li);
        } else

        if (this.options.onCheck.descendants == 'uncheck') {
            this._uncheckDescendants(li);
        }

        // handle ancestors
        if (this.options.onCheck.ancestors == 'check') {
            this._checkAncestors(li);
        } else

        if (this.options.onCheck.ancestors == 'uncheck') {
            this._uncheckAncestors(li);
        } else

        if (this.options.onCheck.ancestors == 'checkIfFull') {
            if (!this._isRoot(li) && this._allDescendantChecked(this._parentNode(li))) {
                this.check(this._parentNode(li));
            }
        }
    },

    /**
     * Check all tree elements
     *
     * Don't use check() method so it won't trigger onCheck events
     *
     * @public
     */
    checkAll: function() {
        $(this.element).find('input:checkbox:not(:checked)').attr('checked', true).change();
    },

    /**
     * Collapse node
     *
     * @public
     *
     * @param li node to collapse
     */
    collapse: function(li) {
        if (li.hasClass('collapsed') || (li.hasClass('leaf'))) {
            return;
        }

        var t = this;

        li.children("ul").hide(this.options.collapseEffect, {}, this.options.collapseDuration);

        setTimeout(function() {
            t._markAsCollapsed(li, t.options);
        }, t.options.collapseDuration);

        t._trigger('collapse', li);
    },

    /**
     * Collapse all nodes of the tree
     *
     * @private
     */
    collapseAll: function() {
        var t = this;
        $(this.element).find('li.expanded').each(function() {
            t.collapse($(this));
        });
    },

    /**
     * Expand node
     *
     * @public
     *
     * @param li node to expand
     */
    expand: function(li) {
        if (li.hasClass('expanded') || (li.hasClass('leaf'))) {
            return;
        }

        var t = this;

        li.children("ul").show(t.options.expandEffect, {}, t.options.expandDuration);

        setTimeout(function() {
            t._markAsExpanded(li, t.options);
        }, t.options.expandDuration);

        t._trigger('expand', li);
    },

    /**
     * Expand all nodes of the tree
     *
     * @public
     */
    expandAll: function() {
        var t = this;
        $(this.element).find('li.collapsed').each(function() {
            t.expand($(this));
        });
    },

    /**
     * Uncheck node
     *
     * @public
     *
     * @param li node to uncheck
     */
    uncheck: function(li) {

        li.find('input:checkbox:first:checked').attr('checked', false).change();

        // handle others
        if (this.options.onUncheck.others == 'check') {
            this._checkOthers(li);
        } else

        if (this.options.onUncheck.others == 'uncheck') {
            this._uncheckOthers(li);
        }

        // handle descendants
        if (this.options.onUncheck.descendants == 'check') {
            this._checkDescendants(li);
        } else

        if (this.options.onUncheck.descendants == 'uncheck') {
            this._uncheckDescendants(li);
        }

        // handle ancestors
        if (this.options.onUncheck.ancestors == 'check') {
            this._checkAncestors(li);
        } else

        if (this.options.onUncheck.ancestors == 'uncheck') {
            this._uncheckAncestors(li);
        }

    },

    /**
     * Uncheck all tree elements
     *
     * Don't use uncheck() method so it won't trigger onUncheck events
     *
     * @public
     */
    uncheckAll: function() {
        $(this.element).find('input:checkbox:checked').attr('checked', false).change();
    },

    /**
     * Default options values
     */
    options: {
        /**
         * Defines if tree has collapse capability.
         */
        collapsable: true,
        /**
         * Defines an element of DOM that, if clicked, trigger collapseAll() method.
         * Value can be either a jQuery object or a selector string.
         * @deprecated will be removed in jquery 0.6.
         */
        collapseAllElement: '',
        /**
         * Defines duration of collapse effect in ms.
         * Works only if collapseEffect is not null.
         */
        collapseDuration: 500,
        /**
         * Defines the effect used for collapse node.
         */
        collapseEffect: 'blind',
        /**
         * Defines URL of image used for collapse anchor.
         * @deprecated will be removed in jquery 0.6.
         */
        collapseImage: '',
        /**
         * Defines jQueryUI icon class used for collapse anchor.
         */
        collapseUiIcon: 'ui-icon-triangle-1-e',
//            dataSourceType: '',
//            dataSourceUrl: '',
        /**
         * Defines an element of DOM that, if clicked, trigger expandAll() method.
         * Value can be either a jQuery object or a selector string.
         * @deprecated will be removed in jquery 0.6.
         */
        expandAllElement: '',
        /**
         * Defines duration of expand effect in ms.
         * Works only if expandEffect is not null.
         */
        expandDuration: 500,
        /**
         * Defines the effect used for expand node.
         */
        expandEffect: 'blind',
        /**
         * Defines URL of image used for expand anchor.
         * @deprecated will be removed in jquery 0.6.
         */
        expandImage: '',
        /**
         * Defines jQueryUI icon class used for expand anchor.
         */
        expandUiIcon: 'ui-icon-triangle-1-se',
        /**
         * Defines if checked node are collapsed or not at tree initializing.
         */
        initializeChecked: 'expanded', // or 'collapsed'
        /**
         * Defines if unchecked node are collapsed or not at tree initializing.
         */
        initializeUnchecked: 'expanded', // or 'collapsed'
        /**
         * Defines URL of image used for leaf anchor.
         * @deprecated will be removed in jquery 0.6.
         */
        leafImage: '',
        /**
         * Defines jQueryUI icon class used for leaf anchor.
         */
        leafUiIcon: '',
        /**
         * Defines which actions trigger when a node is checked.
         * Actions are triggered in the following order:
         * 1) node
         * 2) others
         * 3) descendants
         * 4) ancestors
         */
        onCheck: {
            /**
             * Defines action to perform on ancestors of the checked node.
             * Available values: null, 'check', 'uncheck', 'checkIfFull'.
             */
            ancestors: 'check',
            /**
             * Defines action to perform on descendants of the checked node.
             * Available values: null, 'check', 'uncheck'.
             */
            descendants: 'check',
            /**
             * Defines action to perform on checked node.
             * Available values: null, 'collapse', 'expand'.
             */
            node: '',
            /**
             * Defines action to perform on each other node (checked one excluded).
             * Available values: null, 'check', 'uncheck'.
             */
            others: ''
        },
        /**
         * Defines which actions trigger when a node is unchecked.
         * Actions are triggered in the following order:
         * 1) node
         * 2) others
         * 3) descendants
         * 4) ancestors
         */
        onUncheck: {
            /**
             * Defines action to perform on ancestors of the unchecked node.
             * Available values: null, 'check', 'uncheck'.
             */
            ancestors: '',
            /**
             * Defines action to perform on descendants of the unchecked node.
             * Available values: null, 'check', 'uncheck'.
             */
            descendants: 'uncheck',
            /**
             * Defines action to perform on unchecked node.
             * Available values: null, 'collapse', 'expand'.
             */
            node: '',
            /**
             * Defines action to perform on each other node (unchecked one excluded).
             * Available values: null, 'check', 'uncheck'.
             */
            others: ''
        }
    }

});



/**
 * jquery form to json
 * @author Maxim Vasiliev
 * Date: 29.06.11
 * Time: 20:09
 * https://github.com/maxatwork/form2js
 */


/**
 * Copyright (c) 2010 Maxim Vasiliev
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * @author Maxim Vasiliev
 * Date: 09.09.2010
 * Time: 19:02:33
 */

(function(global)
{
	/**
	 * Returns form values represented as Javascript object
	 * "name" attribute defines structure of resulting object
	 *
	 * @param rootNode {Element|String} root form element (or it's id) or array of root elements
	 * @param delimiter {String} structure parts delimiter defaults to '.'
	 * @param skipEmpty {Boolean} should skip empty text values, defaults to true
	 * @param nodeCallback {Function} custom function to get node value
	 * @param useIdIfEmptyName {Boolean} if true value of id attribute of field will be used if name of field is empty
	 */
	global.form2object = function(rootNode, delimiter, skipEmpty, nodeCallback, useIdIfEmptyName)
	{
		if (typeof skipEmpty == 'undefined' || skipEmpty == null) skipEmpty = true;
		if (typeof delimiter == 'undefined' || delimiter == null) delimiter = '.';
		if (arguments.length < 5) useIdIfEmptyName = false;

		rootNode = typeof rootNode == 'string' ? document.getElementById(rootNode) : rootNode;

		var formValues = [],
			currNode,
			i = 0;

		/* If rootNode is array - combine values */
		if (rootNode.constructor == Array || (typeof NodeList != "undefined" && rootNode.constructor == NodeList))
		{
			while(currNode = rootNode[i++])
			{
				formValues = formValues.concat(getFormValues(currNode, nodeCallback, useIdIfEmptyName));
			}
		}
		else
		{
			formValues = getFormValues(rootNode, nodeCallback, useIdIfEmptyName);
		}

		return processNameValues(formValues, skipEmpty, delimiter);
	};

	/**
	 * Processes collection of { name: 'name', value: 'value' } objects.
	 * @param nameValues
	 * @param skipEmpty if true skips elements with value == '' or value == null
	 * @param delimiter
	 */
	function processNameValues(nameValues, skipEmpty, delimiter)
	{
		var result = {},
			arrays = {},
			i, j, k, l,
			value,
			nameParts,
			currResult,
			arrNameFull,
			arrName,
			arrIdx,
			namePart,
			name,
			_nameParts;

		for (i = 0; i < nameValues.length; i++)
		{
			value = nameValues[i].value;

			if (skipEmpty && (value === '' || value === null)) continue;

			name = nameValues[i].name;
			_nameParts = name.split(delimiter);
			nameParts = [];
			currResult = result;
			arrNameFull = '';

			for(j = 0; j < _nameParts.length; j++)
			{
				namePart = _nameParts[j].split('][');
				if (namePart.length > 1)
				{
					for(k = 0; k < namePart.length; k++)
					{
						if (k == 0)
						{
							namePart[k] = namePart[k] + ']';
						}
						else if (k == namePart.length - 1)
						{
							namePart[k] = '[' + namePart[k];
						}
						else
						{
							namePart[k] = '[' + namePart[k] + ']';
						}

						arrIdx = namePart[k].match(/([a-z_]+)?\[([a-z_][a-z0-9]+?)\]/i);
						if (arrIdx)
						{
							for(l = 1; l < arrIdx.length; l++)
							{
								if (arrIdx[l]) nameParts.push(arrIdx[l]);
							}
						}
						else{
							nameParts.push(namePart[k]);
						}
					}
				}
				else
					nameParts = nameParts.concat(namePart);
			}

			for (j = 0; j < nameParts.length; j++)
			{
				namePart = nameParts[j];

				if (namePart.indexOf('[]') > -1 && j == nameParts.length - 1)
				{
					arrName = namePart.substr(0, namePart.indexOf('['));
					arrNameFull += arrName;

					if (!currResult[arrName]) currResult[arrName] = [];
					currResult[arrName].push(value);
				}
				else if (namePart.indexOf('[') > -1)
				{
					arrName = namePart.substr(0, namePart.indexOf('['));
					arrIdx = namePart.replace(/(^([a-z_]+)?\[)|(\]$)/gi, '');

					/* Unique array name */
					arrNameFull += '_' + arrName + '_' + arrIdx;

					/*
					 * Because arrIdx in field name can be not zero-based and step can be
					 * other than 1, we can't use them in target array directly.
					 * Instead we're making a hash where key is arrIdx and value is a reference to
					 * added array element
					 */

					if (!arrays[arrNameFull]) arrays[arrNameFull] = {};
					if (arrName != '' && !currResult[arrName]) currResult[arrName] = [];

					if (j == nameParts.length - 1)
					{
						if (arrName == '')
						{
							currResult.push(value);
							arrays[arrNameFull][arrIdx] = currResult[currResult.length - 1];
						}
						else
						{
							currResult[arrName].push(value);
							arrays[arrNameFull][arrIdx] = currResult[arrName][currResult[arrName].length - 1];
						}
					}
					else
					{
						if (!arrays[arrNameFull][arrIdx])
						{
							if ((/^[a-z_]+\[?/i).test(nameParts[j+1])) currResult[arrName].push({});
							else currResult[arrName].push([]);

							arrays[arrNameFull][arrIdx] = currResult[arrName][currResult[arrName].length - 1];
						}
					}

					currResult = arrays[arrNameFull][arrIdx];
				}
				else
				{
					arrNameFull += namePart;

					if (j < nameParts.length - 1) /* Not the last part of name - means object */
					{
						if (!currResult[namePart]) currResult[namePart] = {};
						currResult = currResult[namePart];
					}
					else
					{
						currResult[namePart] = value;
					}
				}
			}
		}

		return result;
	}

    function getFormValues(rootNode, nodeCallback, useIdIfEmptyName)
    {
        var result = extractNodeValues(rootNode, nodeCallback, useIdIfEmptyName);
        return result.length > 0 ? result : getSubFormValues(rootNode, nodeCallback, useIdIfEmptyName);
    }

    function getSubFormValues(rootNode, nodeCallback, useIdIfEmptyName)
	{
		var result = [],
			currentNode = rootNode.firstChild,
			callbackResult, fieldValue, subresult;

		while (currentNode)
		{
			result = result.concat(extractNodeValues(currentNode, nodeCallback, useIdIfEmptyName));
			currentNode = currentNode.nextSibling;
		}

		return result;
	}

    function extractNodeValues(node, nodeCallback, useIdIfEmptyName) {
        var callbackResult, fieldValue, result, fieldName = getFieldName(node, useIdIfEmptyName);

        callbackResult = nodeCallback && nodeCallback(node);

        if (callbackResult && callbackResult.name) {
            result = [callbackResult];
        }
        else if (fieldName != '' && node.nodeName.match(/INPUT|TEXTAREA/i)) {
            fieldValue = getFieldValue(node);
			result = [ { name: fieldName, value: fieldValue} ];
        }
        else if (fieldName != '' && node.nodeName.match(/SELECT/i)) {
	        fieldValue = getFieldValue(node);
	        result = [ { name: fieldName.replace(/\[\]$/, ''), value: fieldValue } ];
        }
        else {
            result = getSubFormValues(node, nodeCallback, useIdIfEmptyName);
        }

        return result;
    }

	function getFieldName(node, useIdIfEmptyName)
	{
		if (node.name && node.name != '') return node.name;
		else if (useIdIfEmptyName && node.id && node.id != '') return node.id;
		else return '';
	}


	function getFieldValue(fieldNode)
	{
		//if (fieldNode.disabled) return null;

		switch (fieldNode.nodeName) {
			case 'INPUT':
			case 'TEXTAREA':
				switch (fieldNode.type.toLowerCase()) {
					case 'radio':
					case 'checkbox':
						if (fieldNode.checked) return fieldNode.value;
						break;

					case 'button':
					case 'reset':
					case 'submit':
					case 'image':
						return '';
						break;

					default:
						//수정 부분. class 에 currency가 들어가 있을시 ','를 지운 value를 리턴
						if($(fieldNode).hasClass("currency"))
						{
							return parseInt(jsDeleteComma(fieldNode.value));
						}
						else if($(fieldNode).hasClass("currency1000"))
						{
							return parseInt(jsDeleteComma(fieldNode.value)) * 1000;
						}
						else
							return fieldNode.value;
						break;
				}
				break;

			case 'SELECT':
				return getSelectedOptionValue(fieldNode);
				break;

			default:
				break;
		}

		return null;
	}

	function getSelectedOptionValue(selectNode)
	{
		var multiple = selectNode.multiple,
			result = [],
			options;

		if (!multiple) return selectNode.value;

		for (options = selectNode.getElementsByTagName("option"), i = 0, l = options.length; i < l; i++)
		{
			if (options[i].selected) result.push(options[i].value);
		}

		return result;
	}

	/**
	 * @deprecated Use form2object() instead
	 * @param rootNode
	 * @param delimiter
	 */
	window.form2json = window.form2object;

})(this);
	 
	 
(function($){

	/**
	 * jQuery wrapper for form2object()
	 * Extracts data from child inputs into javascript object
	 */
	$.fn.toObject = function(options)
	{
		var result = [],
			settings = {
				mode: 'first', // what to convert: 'all' or 'first' matched node
				delimiter: ".",
				skipEmpty: true,
				nodeCallback: null,
				useIdIfEmptyName: false
			};

		if (options)
		{
			$.extend(settings, options);
		}

		switch(settings.mode)
		{
			case 'first':
				return form2object(this.get(0), settings.delimiter, settings.skipEmpty, settings.nodeCallback, settings.useIdIfEmptyName);
				break;
			case 'all':
				this.each(function(){
					result.push(form2object(this, settings.delimiter, settings.skipEmpty, settings.nodeCallback, settings.useIdIfEmptyName));
				});
				return result;
				break;
			case 'combine':
				return form2object(Array.prototype.slice.call(this), settings.delimiter, settings.skipEmpty, settings.nodeCallback, settings.useIdIfEmptyName);
				break;
		}
	}

})(jQuery);





